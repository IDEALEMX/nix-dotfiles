#!/bin/bash

echo "=== NIXOS󱄅 UPDATES ==="
echo "1 <-  configurations"
echo "2 <- 󰋜 home-manager"
echo "3 <- 󱄅 flakes"
echo "4 <- 󰊢 git (everything)";
echo "5 <-  rebuild nixvim";
echo "===----------------==="
read -r input

case $input in
	1)
		sudo nixos-rebuild switch --flake ~/.nix/
		;;

	2)
		home-manager switch --flake ~/.nix/
		;;

	3)
		nix flake update
		;;

	4)
    cd ~/.nix/ || return
		git add .
		echo "enter commit message"  
		read -r commit_message
		git commit -m "$commit_message"
		;;

  5)
    nix build ~/.nixvim
    ;;

	*)
		echo "error, unknown option" "$input"
		;;
esac

