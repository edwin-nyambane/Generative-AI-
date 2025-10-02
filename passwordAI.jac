"""AI-Enhanced Password Generator"""

import random;
import string;
import from byllm.llm { Model }

# Setup LLM model (requires valid API key)
glob llm = Model(model_name="gpt-4o-mini", verbose=False);

"""Ask AI to evaluate the generated password's strength and provide tips"""
def evaluate_password(password: str) -> str by llm();

walker PasswordGenerator {
    has length: int;

    can generate with `root entry;
}

node password_node {
    has password: str;
}

# Entry point (runs in CLI mode)
with entry:__main__ {
    root spawn PasswordGenerator(8);    # Generate 8-character password
    root spawn PasswordGenerator(12);   # Generate 12-character password
    root spawn PasswordGenerator(16);   # Generate 16-character password
}

impl PasswordGenerator.generate {
    chars = string.ascii_letters + string.digits + string.punctuation;

    password = "";
    i = 0;
    while i < self.length {
        password += random.choice(chars);
        i += 1;
    }

    node_ref = root ++> password_node(password);
    pw = node_ref[0].password;   # Access first node's password

    print("🔑 Generated Password:", pw);
    print("🤖 AI Evaluation:", evaluate_password(pw));

    disengage;
}
