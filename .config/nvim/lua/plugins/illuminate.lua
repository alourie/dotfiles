-- Highlight same word in the buffer
return {
    { "RRethy/vim-illuminate", event = { "BufReadPost", "BufNewFile" } },
}
