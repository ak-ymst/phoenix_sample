posts model: PhoenixSample.Post, repo: PhoenixSample.Repo do
  long do
    title "長い本文"
    content "この記事は10文字以上の長さがあるよ"
  end
  short do
    title "短い本文"
    content "この記事は8文字"
  end
end
