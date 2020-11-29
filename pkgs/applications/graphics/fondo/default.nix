{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, vala
, pkgconfig
, meson
, ninja
, python3
, glib
, gsettings-desktop-schemas
, gtk3
, libgee
, json-glib
, glib-networking
, libsoup
, libunity
, desktop-file-utils
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "fondo";
  version = "1.3.10";

  src = fetchFromGitHub {
    owner = "calo001";
    repo = pname;
    rev = version;
    sha256 = "0yrbcngmwhn5gl5if9w2cx8shh33zk5fd6iqwnapsq8y0lzq6ppr";
  };

  nativeBuildInputs = [
    desktop-file-utils
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    glib-networking
    gsettings-desktop-schemas
    gtk3
    json-glib
    libgee
    libsoup
    libunity
    pantheon.granite
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  passthru = {
    updateScript = nix-update-script {
      attrPath = pname;
    };
  };


  meta = with stdenv.lib; {
    description = "Find the most beautiful wallpapers for your desktop";
    homepage = "https://github.com/calo001/fondo";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ worldofpeace ];
    platforms = platforms.linux;
  };
}
