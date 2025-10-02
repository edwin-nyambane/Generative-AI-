"""A Password Generator"""

import random;
import string;

walker PasswordGenerator {
    has length: int;

    can generate with `root entry;
}

node password_node {
    has password: str;
}

# Will run when in CLI mode (not in cloud)
with entry:__main__ {
    root spawn PasswordGenerator(8);   # Example: 8-character password
    root spawn PasswordGenerator(12);  # Example: 12-character password
}

impl PasswordGenerator.generate {
    chars = string.ascii_letters + string.digits + string.punctuation;

    password = "";
    i = 0;
    while i < self.length {
        password += random.choice(chars);
        i += 1;
    }

    here = root ++> password_node(password);
    print("Generated Password:", here[0].password);   # <-- FIXED
    disengage;
}
