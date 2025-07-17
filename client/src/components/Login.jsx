import { Form } from "react-router-dom";

function Login() {

    return (
        <div>
            <h2>Login:</h2>
            <form>
                <label> 
                    Username:
                    <input type="text" name = "Username" />
                </label>
                <br />
                <label htmlFor="">
                    Password:
                    <input type="password" name = "password"/>
                </label>
                <br />
                <button>Login</button>
            </form>
        </div>
    )
}

export default Login