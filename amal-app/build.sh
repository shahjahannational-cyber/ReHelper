#!/bin/bash

# Amal App - Automated Build & Release Script
# This script automates building, signing, and distributing the APK

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="Amal"
KEYSTORE_PATH="android/app/keystore.jks"
OUTPUT_DIR="build/app/outputs/flutter-apk"
VERSION_FILE="pubspec.yaml"

# Print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed!"
        print_status "Install from: https://flutter.dev/docs/get-started/install"
        exit 1
    fi
    print_success "Flutter found: $(flutter --version)"
}

# Check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    if ! command -v java &> /dev/null; then
        print_error "Java is not installed!"
        exit 1
    fi
    
    flutter doctor -v || true
    print_success "Dependencies check completed"
}

# Clean previous builds
clean_build() {
    print_status "Cleaning previous builds..."
    flutter clean
    rm -rf build/
    print_success "Build directory cleaned"
}

# Get dependencies
get_dependencies() {
    print_status "Getting Flutter dependencies..."
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs || true
    print_success "Dependencies installed"
}

# Extract version from pubspec.yaml
get_version() {
    grep "^version:" $VERSION_FILE | head -1 | awk '{print $2}'
}

# Update version
update_version() {
    local new_version=$1
    print_status "Updating version to $new_version..."
    
    # Update pubspec.yaml
    sed -i.bak "s/^version:.*/version: $new_version/" $VERSION_FILE
    rm -f $VERSION_FILE.bak
    
    print_success "Version updated to $new_version"
}

# Build Debug APK
build_debug() {
    print_status "Building Debug APK..."
    flutter build apk --debug --verbose
    
    if [ -f "$OUTPUT_DIR/app-debug.apk" ]; then
        print_success "Debug APK built successfully!"
        ls -lh "$OUTPUT_DIR/app-debug.apk"
    else
        print_error "Debug APK build failed!"
        exit 1
    fi
}

# Build Release APK
build_release() {
    print_status "Building Release APK..."
    
    # Check if keystore exists
    if [ ! -f "$KEYSTORE_PATH" ]; then
        print_warning "Keystore not found. Create one using:"
        print_status "keytool -genkey -v -keystore $KEYSTORE_PATH -keyalg RSA -keysize 2048 -validity 10000 -alias amal"
        print_status "Add keystore path to android/key.properties"
        exit 1
    fi
    
    flutter build apk --release --verbose
    
    if [ -f "$OUTPUT_DIR/app-release.apk" ]; then
        print_success "Release APK built successfully!"
        ls -lh "$OUTPUT_DIR/app-release.apk"
    else
        print_error "Release APK build failed!"
        exit 1
    fi
}

# Build AAB (App Bundle) for Play Store
build_aab() {
    print_status "Building App Bundle (AAB) for Google Play Store..."
    flutter build appbundle --release --verbose
    
    if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
        print_success "App Bundle built successfully!"
        ls -lh "build/app/outputs/bundle/release/app-release.aab"
    else
        print_error "App Bundle build failed!"
        exit 1
    fi
}

# Build split APKs for different architectures
build_split_apk() {
    print_status "Building split APKs for different architectures..."
    flutter build apk --release --split-per-abi --verbose
    
    print_success "Split APKs built successfully!"
    ls -lh "$OUTPUT_DIR/app-arm64-v8a-release.apk" 2>/dev/null || true
    ls -lh "$OUTPUT_DIR/app-armeabi-v7a-release.apk" 2>/dev/null || true
    ls -lh "$OUTPUT_DIR/app-x86_64-release.apk" 2>/dev/null || true
}

# Generate changelog
generate_changelog() {
    print_status "Generating changelog..."
    
    local changelog_file="CHANGELOG_BUILD_$(date +%Y%m%d_%H%M%S).txt"
    
    cat > "$changelog_file" << EOF
=== $APP_NAME Build Report ===
Date: $(date)
Version: $(get_version)
Build Type: $1

System Information:
- Flutter: $(flutter --version)
- Dart: $(dart --version)
- Platform: $(uname -s)

Build Output:
EOF

    if [ -f "$OUTPUT_DIR/app-release.apk" ]; then
        echo "APK Size: $(du -h $OUTPUT_DIR/app-release.apk | cut -f1)" >> "$changelog_file"
        echo "APK Path: $OUTPUT_DIR/app-release.apk" >> "$changelog_file"
    fi
    
    print_success "Changelog generated: $changelog_file"
}

# Create GitHub release
create_github_release() {
    local version=$1
    local apk_path=$2
    
    print_status "Creating GitHub release v$version..."
    
    if ! command -v gh &> /dev/null; then
        print_warning "GitHub CLI not found. Skipping GitHub release creation."
        print_status "Install from: https://cli.github.com"
        return
    fi
    
    # Create release
    gh release create "v$version" \
        --title "$APP_NAME v$version" \
        --notes "Automated release build" \
        "$apk_path" \
        || print_warning "Release creation failed or already exists"
    
    print_success "GitHub release created!"
}

# Upload to Google Play Store (manual)
upload_play_store_info() {
    print_status "Google Play Store upload instructions:"
    echo -e "${YELLOW}"
    echo "1. Sign into Google Play Console"
    echo "2. Select $APP_NAME"
    echo "3. Go to Release > Production"
    echo "4. Click 'Create new release'"
    echo "5. Upload: build/app/outputs/bundle/release/app-release.aab"
    echo "6. Fill in release notes"
    echo "7. Review and publish"
    echo -e "${NC}"
}

# Show usage
show_usage() {
    cat << EOF
Usage: $0 [COMMAND] [OPTIONS]

Commands:
    debug                   Build debug APK
    release                 Build release APK
    aab                     Build App Bundle (for Play Store)
    split                   Build split APKs by architecture
    full                    Build everything (debug, release, AAB)
    clean                   Clean build directory
    version                 Show current version

Options:
    --version VERSION       Update version before building
    --changelog             Generate changelog
    --release               Create GitHub release
    --tag TAG               GitHub release tag
    --help                  Show this help message

Examples:
    $0 debug
    $0 release --version 1.1.0
    $0 release --release --tag v1.1.0
    $0 full --version 1.2.0 --changelog

EOF
}

# Main build process
main() {
    local command=$1
    local version=""
    local should_changelog=false
    local should_release=false
    local tag=""
    
    # Parse arguments
    shift || true
    while [[ $# -gt 0 ]]; do
        case $1 in
            --version)
                version="$2"
                shift 2
                ;;
            --changelog)
                should_changelog=true
                shift
                ;;
            --release)
                should_release=true
                shift
                ;;
            --tag)
                tag="$2"
                shift 2
                ;;
            --help|-h)
                show_usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    # Check Flutter installation
    check_flutter
    check_dependencies
    
    # Update version if specified
    if [ -n "$version" ]; then
        update_version "$version"
    fi
    
    # Execute command
    case $command in
        debug)
            clean_build
            get_dependencies
            build_debug
            ;;
        release)
            clean_build
            get_dependencies
            build_release
            if [ "$should_changelog" = true ]; then
                generate_changelog "release"
            fi
            if [ "$should_release" = true ]; then
                local current_version=$(get_version)
                local release_tag=${tag:-"v$current_version"}
                create_github_release "$release_tag" "$OUTPUT_DIR/app-release.apk"
            fi
            ;;
        aab)
            clean_build
            get_dependencies
            build_aab
            upload_play_store_info
            ;;
        split)
            clean_build
            get_dependencies
            build_split_apk
            ;;
        full)
            clean_build
            get_dependencies
            build_debug
            build_release
            build_aab
            if [ "$should_changelog" = true ]; then
                generate_changelog "full"
            fi
            ;;
        clean)
            clean_build
            ;;
        version)
            print_status "Current version: $(get_version)"
            ;;
        *)
            print_error "Unknown command: $command"
            show_usage
            exit 1
            ;;
    esac
    
    print_success "Build process completed!"
}

# Run main if script is executed
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    if [ $# -eq 0 ]; then
        show_usage
        exit 1
    fi
    main "$@"
fi
