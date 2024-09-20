{
  description = "Stamm Barrakuda Web Page";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.cf.url = "github:jzbor/cornflakes";

  outputs = { self, nixpkgs, cf }:
  let
    libcf = cf.mkLib nixpkgs;
  in libcf.flakeForDefaultSystems (system:
  let
    cloudURL = "https://cloud.barrakuda.de";
    webspaceAdminURL = "https://secure.hosting.de";
    pkgs = libcf.mkPkgs system;
  in {
    packages.default = pkgs.stdenvNoCC.mkDerivation {
      name = "barrakuda-de";
      src = ./.;
      buildPhase = ''
        mkdir -vp $out
        ${pkgs.hugo}/bin/hugo -d $out
      '';
      installPhase = "";
    };

    devShells.default = pkgs.mkShell {
      name = "barrakuda-de";
      nativeBuildInputs = with pkgs; [
        hugo
        rclone
      ];
    };

    apps = {
      login-cloud = libcf.createShellApp system {
        name = "imgsync-login-cloud";
        text = ''
          echo "Please setup the cloud as new remote \"barrakuda-cloud\"."
          echo
          echo "URL: ${cloudURL}/remote.php/dav/files/YOUR_USER"
          echo
          echo "You can create a new app password at ${cloudURL}/settings/user/security"
          echo
          ${pkgs.rclone}/bin/rclone config create barrakuda-cloud webdav \
              vendor nextcloud \
              bearer_token "" \
              --all "$@"
        '';
      };

      login-web = libcf.createShellApp system {
        name = "imgsync-login-web";
        text = ''
          echo "Please setup the web host as new remote \"barrakuda-web\"."
          echo
          echo "You can create a new sftp login at ${webspaceAdminURL}/webhosting/webspaces/overview"
          echo
          ${pkgs.rclone}/bin/rclone config create barrakuda-web sftp \
              --all "$@"
        '';
      };

      imgsync = libcf.createShellApp system {
        name = "imgsync";
        text = ''
          ${pkgs.rclone}/bin/rclone sync -v barrakuda-cloud:WebBilder barrakuda-web:html/barrakuda.de/images
        '';
      };

      deploy = libcf.createShellApp system {
        name = "deploy";
        text = ''
          ${pkgs.rclone}/bin/rclone sync -v ${self.packages.${system}.default} barrakuda-web:html/barrakuda.de/ --exclude images/
        '';
      };
    };
  });
}




