cask "fig" do
  version "1.0.59,487"
  sha256 "1e81b6c69c4512ed40b5788c14d4d53679865e10d291f436807027b3fb18ad59"

  url "https://versions.withfig.com/fig%20#{version.csv.second}.dmg",
      verified: "versions.withfig.com/"
  name "fig"
  desc "Reimagine your terminal"
  homepage "https://fig.io/"

  livecheck do
    url "https://versions.withfig.com/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: ">= :high_sierra"

  app "Fig.app"
  binary "#{appdir}/Fig.app/Contents/MacOS/fig-darwin-universal", target: "fig"

  uninstall script:
                       {
                         executable: "#{appdir}/Fig.app/Contents/MacOS/fig-darwin-universal",
                         args:       ["app", "uninstall"],
                       },
            launchctl:
                       [
                         "io.fig.launcher",
                         "io.fig.uninstall",
                         "io.fig.dotfiles-daemon",
                       ],
            quit:
                       [
                         "com.mschrage.fig",
                         "io.fig.input-method.cursor",
                       ]

  zap trash: [
    "~/.fig",
    "~/.fig.dotfiles.bak",
    "~/Library/Application Support/com.mschrage.fig",
    "~/Library/Application Support/fig",
    "~/Library/Caches/com.mschrage.fig",
    "~/Library/Caches/fig",
    "~/Library/HTTPStorages/com.mschrage.fig",
    "~/Library/Preferences/com.mschrage.fig.*",
    "~/Library/WebKit/com.mschrage.fig",
  ]

  caveats <<~EOS
    Please launch the Fig application to finish setup...
  EOS
end
