net.Receive("AtlasPropCount.Notify", function()
    local count = tostring(net.ReadUInt(16))
    local max = tostring(ATLASPROPS.CFG.PropCount)
    chat.AddText(Color(255,56,56), "| ", Color(255, 255, 255), "You have ", Color(203, 177, 5), count, Color(255, 255, 255), " out of ", Color(215, 71, 24), max, Color(255, 255, 255), " spawned props.")
end)