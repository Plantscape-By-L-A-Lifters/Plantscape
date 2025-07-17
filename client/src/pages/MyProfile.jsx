import { Link } from "react-router";

export default function MyProfile() {
  return (
    <div>
      <h1>user profile</h1>
      <h3>
        <Link to="/newproject">Start a New Project</Link>
      </h3>
      <h2>My Projects</h2>
      {/* TODO: map through users projects */}
      <ul>
        <li>
          <Link to="/myproject">My Project</Link>
        </li>
      </ul>
    </div>
  );
}
