final: prev: {
  jetbrains = prev.jetbrains // {
    idea-ultimate = prev.jetbrains.idea-ultimate.overrideAttrs (oldAttrs: {
      src = fetchTarball {
        url = "https://download.jetbrains.com/idea/ideaIU-2023.3.tar.gz";
        sha256 = "sha256:0n506ngzkcdcb53h1aidiamfmq1f1d4f72didwjdfibvwiyyrqg2";
      };

      version = "2023.3";
    });
  };
}
