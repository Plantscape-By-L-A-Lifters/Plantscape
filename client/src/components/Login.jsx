import axios from "axios";
import { useNavigate } from "react-router-dom";
import { useState, useContext } from "react";
import { UserContext } from "../context/UserContext";

function Login() {
  const navigate = useNavigate();
  const [error, setError] = useState("");
  const { attemptLogin } = useContext(UserContext);

  const login = async (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    const username = formData.get("username");
    const password = formData.get("password");

    const user = {
      username,
      password,
    };

    try {
      setError("");
      const { data } = await axios.post("/api/authenticate/login", user);
      const { token } = data;
      window.localStorage.setItem("token", token);
      await attemptLogin();
      navigate("/profile");
    } catch (error) {
      console.error(error);
      if (error.status === 401) {
        setError("incorrect credentials");
      } else {
        setError(error.message);
      }
    }
  };

  return (
    <div>
      <h2>Login:</h2>
      {error && <p style={{ color: "red" }}>{error}</p>}
      <form onSubmit={login}>
        <label>
          Username:
          <input
            type="text"
            id="username"
            name="username"
            autoComplete="username"
            required
          />
        </label>
        <br />
        <label>
          Password:
          <input
            type="password"
            id="password"
            name="password"
            autoComplete="current-password"
            required
          />
        </label>
        <br />
        <button type="submit">Login</button>
        <h3>or </h3>
      </form>
      <button onClick={toRegister}>Register</button>
    </div>
  );
}
const toRegister = () => {
  navigate("/register");
};

export default Login;
