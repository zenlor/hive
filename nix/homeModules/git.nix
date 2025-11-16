{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ghq
    gitu
    git-extras
    git-stack
    tig
    git-branchless
    git-branchstack
  ];

  programs.git = {
    enable = true;

    ignores = [
      ".dir-locals.el"
      ".DS_Store"
      ".lsp"
      ".clj-kondo"
      ".direnv"
    ];

    settings.aliases = {
      fixup = ''!f() { TARGET=$(git rev-parse "$1"); git commit --fixup=$TARGET ''${@:2} && EDITOR=true git rebase -i --autostash --autosquash $TARGET^; }; f'';
      co = "checkout";
      st = "status";
      l = "log --date=format:'%a %b %e, %Y' --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cd%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph";
      cl = "!ghq get";
      z = "!lazygit";
    };

    settings = {
      core.autocrlf = "input";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "current";
      push.autoSetupRemote = true;
      rebase.autosquash = true;
      rerere.enabled = true;
      merge.conflictStyle = "diff3";
      status.submoduleSummary = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed-signers";
      help.autocorrect = 0;
      ghq.root = "~/lib/src";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
    extensions = [ pkgs.gh-eco ];
  };

  programs.lazygit = {
    enable = true;
  };

  programs.gitui = {
    enable = true;
    # From: https://github.com/gitui-org/gitui/blob/master/vim_style_key_config.ron
    keyConfig = ''
      (
        open_help: Some(( code: F(1), modifiers: "")),

        move_left: Some(( code: Char('h'), modifiers: "")),
        move_right: Some(( code: Char('l'), modifiers: "")),
        move_up: Some(( code: Char('k'), modifiers: "")),
        move_down: Some(( code: Char('j'), modifiers: "")),

        popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
        popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
        page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
        page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
        home: Some(( code: Char('g'), modifiers: "")),
        end: Some(( code: Char('G'), modifiers: "SHIFT")),
        shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
        shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

        edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

        status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

        diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
        diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

        stashing_save: Some(( code: Char('w'), modifiers: "")),
        stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

        stash_open: Some(( code: Char('l'), modifiers: "")),

        abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
      )
    '';
    theme = ''
      (
        selected_tab: Some("Reset"),
        command_fg: Some("#c6d0f5"),
        selection_bg: Some("#626880"),
        selection_fg: Some("#c6d0f5"),
        cmdbar_bg: Some("#292c3c"),
        cmdbar_extra_lines_bg: Some("#292c3c"),
        disabled_fg: Some("#838ba7"),
        diff_line_add: Some("#a6d189"),
        diff_line_delete: Some("#e78284"),
        diff_file_added: Some("#a6d189"),
        diff_file_removed: Some("#ea999c"),
        diff_file_moved: Some("#ca9ee6"),
        diff_file_modified: Some("#ef9f76"),
        commit_hash: Some("#babbf1"),
        commit_time: Some("#b5bfe2"),
        commit_author: Some("#85c1dc"),
        danger_fg: Some("#e78284"),
        push_gauge_bg: Some("#8caaee"),
        push_gauge_fg: Some("#303446"),
        tag_fg: Some("#f2d5cf"),
        branch_fg: Some("#81c8be")
      )
    '';
  };
}
