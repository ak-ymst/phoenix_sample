defmodule PhoenixSample.Post do
  use PhoenixSample.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string

    has_many :comments, PhoenixSample.Comment
    
    timestamps
  end

  @required_fields ~w(title content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  @doc """
    引数の文字列が10文字を超えていた場合、それを切り詰める
  """
  def truncate(content) do
    if String.length(content) > 9 do
      String.slice(content, 0..9) <> "..."
    else
      content
    end
  end
end
