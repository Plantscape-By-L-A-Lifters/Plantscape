import axios from "axios"
import { useNavigate } from "react-router-dom"
import { useState } from "react"
import { toast, ToastContainer } from "react-toastify"
import 'react-toastify/dist/ReactToastify.css'

const Register = () => {
    const navigate = useNavigate()
    const [error,setError] = useState('')


    const register = async (formData) => {
        const username = formData.get('username')
        const password = formData.get('password')

        const user = {
            username,
            password
        }
        try {
            const {data} = await axios.post('/api/users/register',user)
            toast.success('Registration Was A Success')
            navigate('/profile')
        } catch (error) {
           if(error.status === 500){
            toast.error("Registration Has Failed")
        }else{
            setError(error.message)
        }
        }
    }

    return (
        <div>
            <h1>Register</h1>
            <form action={register}>
                <label>
                    Username:
                    <input type="text" name="username"/>
                </label>
                <br />
                <label>
                    Password:
                    <input type="password" name="password"/>
                </label>
                <button>register</button>
            </form>
            <ToastContainer/>
        </div>
    )
}

export default Register