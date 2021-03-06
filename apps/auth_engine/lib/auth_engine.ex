defmodule AuthEngine do
  use Ace.HTTP.Service, port: 85, cleartext: true
  use Raxx.Static, "./static"

  use Raxx.Router, [
    {%{method: :GET, path: ["ping"]}, Api.Ping},
    {%{method: :POST, path: ["auth"]}, Api.Auth},
    {%{method: :POST, path: ["auth", _, _]}, Api.AuthCheck},
    {%{method: :GET, path: ["user", _]}, Api.GetUser},
    {%{method: :POST, path: ["user", _]}, Api.UpdateUser},
    {%{method: :POST, path: ["user"]}, Api.CreateUser},
    {%{method: :GET, path: ["verify", "gen", _]}, Api.VerifyGen},
    {%{method: :GET, path: ["verify", _, _]}, Api.VerifyUser},
    {%{method: :GET, path: ["score", _]}, Api.GetScores},
    {%{method: :PUT, path: ["score", _], body: true}, Api.SubmitScore},
    {_, Api.NotFound}
  ]
end
