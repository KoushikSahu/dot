local notify = vim.notify
vim.notify = function(msg, ...)
  if type(msg) == "string" and msg:match("warning: multiple different client offset_encodings") then
    return
  end
  notify(msg, ...)
end