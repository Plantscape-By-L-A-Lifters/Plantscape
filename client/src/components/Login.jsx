import axios from "axios"
import { useNavigate } from "react-router-dom"
import { useState } from "react"


function Login({attemptLogin}) {
const navigate = useNavigate()
const [error, setError] = useState('')

const login = async (e) =>{
    e.preventDefault()
    const formData = new FormData(e.target)
    const username = formData.get('username')
    const password = formData.get('password')

    const user = {
        username,
        password
    }

    try {
        setError('')
        const { data } = await axios.post('/api/authenticate/login', user)
        const { token } = data
        window.localStorage.setItem('token', token)
        attemptLogin()
        navigate('/profile')
    } catch (error) {
        console.error(error)
        if (error.status === 401) {
            setError('incorrect credentials')
        } else {
             setError(error.message)
        }
    }
}
const toRegister = () =>{
navigate('/register')
}

    return (
        <div>
            <h2>Login:</h2>
            <form onSubmit = {login}>
                <label> 
                    Username:
                    <input type="text" name = "username" />
                </label>
                <br />
                <label>
                    Password:
                    <input type="password" name = "password"/>
                </label>
                <br />
                <button type="submit">Login</button> <h3>or </h3>
            </form>
            <button onClick={toRegister}>Register</button>
              
        </div>
    )
}

export default Login

