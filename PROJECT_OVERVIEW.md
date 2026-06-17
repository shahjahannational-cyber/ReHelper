# 🌟 Amal - Complete Project Overview

A comprehensive mobile application for productivity, personal development, and Islamic lifestyle management.

## 📱 What is Amal?

**Amal** is a holistic productivity app that combines:
- YouTube Playlist Management
- Islamic Prayer Times (5 Daily Prayers)
- Pomodoro Time Management
- Daily Timetable & Scheduling
- Content Blocker (Websites & Apps)
- Rich Notes Editor
- Achievement System with Gamification
- Automatic Data Backup & Export

## 🚀 Quick Start

### For Developers

```bash
# Setup
cd amal-app
flutter pub get

# Run
flutter run --release

# Build APK
bash instant_build.sh
```

### For Users

1. Download APK from [Releases](https://github.com/shahjahannational-cyber/rehelper/releases)
2. Enable Unknown Sources in Android Settings
3. Install APK
4. Open Amal and start your journey!

## 📁 Project Structure

```
rehelper/
├── amal-app/                    # Main Flutter app
│   ├── lib/
│   │   ├── main.dart           # Entry point
│   │   ├── screens/            # UI screens
│   │   ├── widgets/            # Reusable widgets
│   │   ├── services/           # Business logic
│   │   ├── models/             # Data models
│   │   ├── providers/          # State management
│   │   ├── config/             # App configuration
│   │   ├── utils/              # Utilities
│   │   └── assets/             # Images, fonts, sounds
│   ├── android/                # Android native
│   ├── ios/                    # iOS native
│   ├── pubspec.yaml            # Dependencies
│   ├── build.sh                # Build script
│   ├── instant_build.sh        # Instant builder
│   ├── SETUP_GUIDE.md          # Setup instructions
│   ├── ARCHITECTURE.md         # Architecture docs
│   └── README.md               # App documentation
├── .github/
│   └── workflows/
│       └── build_release.yml   # CI/CD pipeline
└── QUICK_START_BUILD.md        # This file
```

## ✨ Key Features

### 🎬 YouTube Playlist Manager
- Add multiple playlists
- Resume playback from last timestamp
- Track watch history
- Quick video access

### 🕐 Prayer Times Integration
- 5 daily Islamic prayers
- Location-based calculation
- Automatic notifications
- Prayer tracker & statistics

### ⏱️ Pomodoro Timer
- Multiple activity categories
- Customizable durations
- Daily auto-scheduling
- Background timer support
- Session history

### 📅 Daily Timetable
- Hourly activity scheduling
- Recurring routines
- Alarm notifications
- Color-coded activities
- Conflict detection

### 🚫 Content Blocker
- Block harmful websites
- Block distracting apps
- Whitelist exceptions
- Usage analytics
- Achievement rewards

### 📝 Notes & Journal
- Rich text formatting (Bold, Italic, Links)
- Note grouping
- Built-in calculator
- Image attachments
- Full-text search

### 🏆 Achievement System
- Weekly badges
- Monthly milestones
- Yearly rewards
- Streak tracking
- Motivation scores

### 💾 Data Management
- Export as .aml or .json
- Auto-backups
- Cloud sync (optional)
- One-tap restore

## 🛠️ Technologies Used

| Component | Technology |
|-----------|-----------|
| UI Framework | Flutter 3.10+ |
| State Mgmt | Riverpod |
| Database | Hive / SQLite |
| APIs | YouTube, Prayer Times |
| Notifications | flutter_local_notifications |
| Rich Text | flutter_quill |
| Maps | Location APIs |

## 📊 App Statistics

- **Lines of Code:** 5,000+
- **Classes/Models:** 12+
- **State Providers:** 8+
- **Services:** 7+
- **Screens:** 8+
- **Features:** 15+

## 🔧 Build & Deployment

### One-Command Build
```bash
cd amal-app
bash instant_build.sh
```

### Build Options
```bash
# Debug APK
bash build.sh debug

# Release APK
bash build.sh release

# App Bundle (Play Store)
bash build.sh aab

# Split APKs
bash build.sh split

# Everything
bash build.sh full
```

### Distribute to Users
- GitHub Releases
- Direct download
- Google Play Store
- Firebase distribution

## 📚 Documentation

- **[SETUP_GUIDE.md](amal-app/SETUP_GUIDE.md)** - Installation & setup
- **[ARCHITECTURE.md](amal-app/ARCHITECTURE.md)** - Code architecture
- **[QUICK_START_BUILD.md](QUICK_START_BUILD.md)** - Build guide
- **[amal_export_format.md](amal-app/amal_export_format.md)** - Export format spec

## 🎓 Learning Resources

- [Flutter Official Docs](https://flutter.dev)
- [Riverpod Guide](https://riverpod.dev)
- [Clean Architecture](https://resocoder.com/clean-architecture-tdd)
- [YouTube Data API](https://developers.google.com/youtube/v3)

## 🤝 Contributing

Contributions welcome! Please:
1. Fork repository
2. Create feature branch
3. Make changes
4. Submit pull request

## 📄 License

MIT License - Feel free to use commercially

## 👨‍💻 Author

**Shahjahan National Cyber**
- GitHub: [@shahjahannational-cyber](https://github.com/shahjahannational-cyber)

## 🔗 Links

- **Repository:** https://github.com/shahjahannational-cyber/rehelper
- **Issues:** https://github.com/shahjahannational-cyber/rehelper/issues
- **Releases:** https://github.com/shahjahannational-cyber/rehelper/releases

---

## 🎯 Roadmap

### Phase 1 (Current)
- ✅ Core app structure
- ✅ YouTube integration
- ✅ Prayer times
- ✅ Pomodoro timer
- ✅ Timetable
- ✅ Content blocker
- ✅ Notes & achievements

### Phase 2 (Upcoming)
- 🔲 Firebase cloud sync
- 🔲 User accounts
- 🔲 Social features
- 🔲 Analytics dashboard
- 🔲 Web version

### Phase 3 (Future)
- 🔲 AI-powered suggestions
- 🔲 Community challenges
- 🔲 Cross-platform sync
- 🔲 Apple Watch support

## 💡 Tips

1. **First Time Setup:**
   ```bash
   flutter doctor
   cd amal-app
   flutter pub get
   flutter run
   ```

2. **Fast Development:**
   ```bash
   flutter run --hot
   # Hot reload on code changes
   ```

3. **Production Build:**
   ```bash
   bash instant_build.sh
   # Full optimized build in one command
   ```

4. **Share with Others:**
   - Build release APK
   - Create GitHub release
   - Share download link

## ⚡ Performance Tips

- Use `flutter build apk --release` for optimization
- Enable minification and resource shrinking
- Use split APKs for different architectures
- Lazy load screens and data

## 🔐 Security Reminders

- Never commit API keys
- Use `.env` for secrets
- Update dependencies regularly
- Test before release
- Use code obfuscation

## ❓ FAQ

**Q: Can I use this commercially?**
A: Yes! It's MIT licensed.

**Q: How do I report bugs?**
A: Open an issue on GitHub.

**Q: Can I contribute features?**
A: Absolutely! Submit a PR.

**Q: Is there Windows/Web version?**
A: Not yet, but planned.

---

## 🎉 Ready to Build?

```bash
cd amal-app && bash instant_build.sh
```

**Congratulations! Your Amal productivity app is ready! 🚀**

---

*Last Updated: June 17, 2024*
*Built with ❤️ for Islamic productivity*
