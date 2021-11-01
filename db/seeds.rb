memes = [
    {
        name: "Felix",
        url: "http://google.com",
        description: "a warm fire"
    },
    {
        name: "Lola",
        url: "http://google.com",
        description: "hairball fetish"
    },
    {
        name: "Toast",
        url: "http://google.com",
        description: "warm butter"
    },
    {
        name: "Chesire",
        url: "http://google.com",
        description: "useless advice"
    }
]

memes.each do |attributes|
    Meme.create attributes
    p "creating memes #{attributes}"
end
