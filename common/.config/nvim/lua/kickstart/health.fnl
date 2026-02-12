(local check-version
  (fn []
    (let [v (vim.version)
          verstr (string.format "%s.%s.%s" v.major v.minor v.patch)]
      (if (not vim.version.cmp)
        (vim.health.error (string.format "Neovim out of date: '%s'. Upgrade to latest stable or nightly" verstr))
        (if (>= (vim.version.cmp (vim.version) [0 9 4]) 0)
          (vim.health.ok (string.format "Neovim version is: '%s'" verstr))
          (vim.health.error (string.format "Neovim out of date: '%s'. Upgrade to latest stable or nightly" verstr)))))))

(local check-external-reqs
  (fn []
    (each [_ exe (ipairs [:git :make :unzip :rg])]
      (if (= (vim.fn.executable exe) 1)
        (vim.health.ok (string.format "Found executable: '%s'" exe))
        (vim.health.warn (string.format "Could not find executable: '%s'" exe))))
    true))

{:check (fn []
          (vim.health.start "kickstart.nvim")
          (vim.health.info "NOTE: Not every warning is a 'must-fix' in `:checkhealth`

  Fix only warnings for plugins and languages you intend to use.
    Mason will give warnings for languages that are not installed.
    You do not need to install, unless you want to use those languages!")
          (let [uv (or vim.uv vim.loop)]
            (vim.health.info (.. "System Information: " (vim.inspect (uv.os_uname)))))
          (check-version)
          (check-external-reqs))}
