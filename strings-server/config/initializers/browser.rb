Rails.configuration.middleware.use Browser::Middleware do
  # redirect_to upgrade_index_path(browser: "oldfx") if !browser.firefox?
  next if browser.bot.search_engine?
end
