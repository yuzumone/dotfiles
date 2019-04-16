#!/bin/sh
HOST=localhost

usage() {
    cat <<EOF
$(basename ${0}) is a tool for sync dotfiles and packages.

Usage:
    $(basename ${0}) [command] [<options>]

Command:
    sync-dotfile            sync dotfiles
    add-dotfile [dotfile]   add dotfile
    rm-dotfile              remove all dotfiles
    sync-apt                sync apt packages
    install-apt [package]   add apt package
    sync-yum                sync yum packages
    install-yum [package]   add yum package
    sync-brew               sync homebrew packages
    install-brew [package]  add homebrew package
    sync-cask               sync homebrew cask packages
    install-cask [package]  add homebrew cask package
    help                    print this

Options:
    --host                  host ip address
EOF
}

case ${1} in
    sync-dotfile)
        case ${2} in '--host') HOST=${3};; esac
        if [ $HOST = localhost ]
        then
            ansible-playbook -i $HOST, -c local playbook.yml --tags sync-dot-files
        else
            ansible-playbook -i $HOST, playbook.yml --tags sync-dot-files
        fi
    ;;

    add-dotfile)
        case ${2} in "")
            echo "\e[31mRequire dotfile name...\e[m"
            usage
            exit 1
        ;; esac
        echo "\e[32mAdd dotfile ${2}\e[m"
        ansible-playbook -i localhost, -c local playbook.yml --tags add-dot-file --extra-vars="dotfile=${2}"
    ;;

    rm-dotfile)
        case ${2} in '--host') HOST=${3};; esac
        if [ $HOST = localhost ]
        then
            ansible-playbook -i $HOST, -c local playbook.yml --tags remove-dot-files
        else
            ansible-playbook -i $HOST, playbook.yml --tags remove-dot-files
        fi
    ;;

    sync-apt)
        case ${2} in '--host') HOST=${3};; esac
        if [ $HOST = localhost ]
        then
            ansible-playbook -i $HOST, -c local playbook.yml --tags sync-apt-packages --ask-sudo-pass
        else
            ansible-playbook -i $HOST, playbook.yml --tags sync-apt-packages --ask-sudo-pass
        fi
    ;;

    install-apt)
        case ${2} in "")
            echo "\e[31mRequire package name...\e[m"
            usage
            exit 1
        ;; esac
        echo "\e[32mInstall ${2} of apt\e[m"
        ansible-playbook -i localhost, -c local playbook.yml --tags install-apt-package --extra-vars="package=${2}" --ask-sudo-pass
    ;;

    sync-yum)
        case ${2} in '--host') HOST=${3};; esac
        if [ $HOST = localhost ]
        then
            ansible-playbook -i $HOST, -c local playbook.yml --tags sync-yum-packages --ask-sudo-pass
        else
            ansible-playbook -i $HOST, playbook.yml --tags sync-yum-packages --ask-sudo-pass
        fi
    ;;

    install-yum)
        case ${2} in "")
            echo "\e[31mRequire package name...\e[m"
            usage
            exit 1
        ;; esac
        echo "\e[32mInstall ${2} of yum\e[m"
        ansible-playbook -i localhost, -c local playbook.yml --tags install-yum-package --extra-vars="package=${2}" --ask-sudo-pass
    ;;

    sync-brew)
        ansible-playbook -i $HOST, -c local playbook.yml --tags sync-brew-packages
    ;;

    install-brew)
        case ${2} in "")
            echo "\e[31mRequire package name...\e[m"
            usage
            exit 1
        ;; esac
        echo "\e[32mInstall ${2} of homebrew\e[m"
        ansible-playbook -i localhost, -c local playbook.yml --tags install-brew-package --extra-vars="package=${2}"
    ;;

    sync-cask)
        ansible-playbook -i $HOST, -c local playbook.yml --tags sync-cask-packages
    ;;

    install-cask)
        case ${2} in "")
            echo "\e[31mRequire package name...\e[m"
            usage
            exit 1
        ;; esac
        echo "\e[32mInstall ${2} of homebrew cask\e[m"
        ansible-playbook -i localhost, -c local playbook.yml --tags install-cask-package --extra-vars="package=${2}"
    ;;

    help|--help|-h|"")
        usage
    ;;

    *)
        echo "[ERROR] Invalid subcommand '${1}'"
        usage
        exit 1
    ;;
esac

