import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

const sonarGuide = '''<!DOCTYPE html>
<html lang="en">
<body>
    <h1>Guide to Integrate Sonar Cloud with Backend</h1>

    <h2>Step 1: Configure Secrets in GitHub Repository</h2>
    <p>To securely store sensitive information like backend URLs, follow these steps:</p>
    <ol>
        <li>Go to your GitHub repository and click on <strong>Settings</strong>.</li>
        <li>In the left sidebar, select <strong>Secrets and variables</strong> > <strong>Actions</strong>.</li>
        <li>Click the <strong>New repository secret</strong> button.</li>
        <li>Add a new secret with the following details:
            <ul>
                <li><strong>Name:</strong> <code>BACKEND_URL</code></li>
                <li><strong>Value:</strong> The base URL of your backend (e.g., <code>https://your-backend-url.com</code>).</li>
            </ul>
        </li>
        <li>Click <strong>Add secret</strong> to save.</li>
    </ol>

    <h2>Step 2: Add Sonar Cloud Action to Workflow</h2>
    <p>After integrating Sonar Cloud into your project, you can enhance the workflow by adding a notification step to send vulnerability reports to the backend. Add the following steps to your GitHub Actions workflow file (<code>.github/workflows/your-workflow.yml</code>):</p>

    <pre><code>      - name: Load variables from sonar-project.properties
        run: |
          # Read the project key of Sonar Cloud
          sonar_project_key=\$(grep '^sonar.projectKey=' sonar-project.properties | cut -d '=' -f2)

          # Set variable to GITHUB_ENV
          echo "SONAR_PROJECT_KEY=\$sonar_project_key" >> \$GITHUB_ENV

      - name: Send notification to receive vulnerabilities from Sonar Cloud
        run: |
          curl -X POST \${{secrets.BACKEND_URL}}/reports/sonar?projectName=\$GITHUB_REPOSITORY&sonarProjectKey=\$SONAR_PROJECT_KEY 
           -H "Content-Type: application/json"
    </code></pre>

    <h2>Step 3: Explanation of the Workflow Steps</h2>
    <p>The above steps perform the following actions:</p>
    <ul>
        <li><strong>Load Variables:</strong> Extracts the <code>sonar.projectKey</code> from the <code>sonar-project.properties</code> file and sets it as an environment variable.</li>
        <li><strong>Send Notification:</strong> Sends a POST request to the backend URL with the following parameters:
            <ul>
                <li><code>projectName:</code> The GitHub repository name.</li>
                <li><code>sonarProjectKey:</code> The Sonar Cloud project key.</li>
            </ul>
        </li>
    </ul>

    <h2>Step 4: Verify the Integration</h2>
    <p>Once the workflow runs successfully:</p>
    <ol>
        <li>Ensure the <code>BACKEND_URL</code> is reachable from the GitHub Actions runner.</li>
        <li>Check the backend server logs to confirm the receipt of the data from Sonar Cloud.</li>
    </ol>

    <p>You have now successfully integrated Sonar Cloud with your backend, enabling seamless transfer of vulnerability reports.</p>
</body>
</html>
''';

const oswaspGuide = '''<!DOCTYPE html>
<html lang="en">
<body>
    <h1>Guide to Integrate OWASP Dependency-Check</h1>

    <h2>Step 1: Configure Secrets in GitHub Repository</h2>
    <p>To securely store sensitive information like backend URLs, follow these steps:</p>
    <ol>
        <li>Go to your GitHub repository and click on <strong>Settings</strong>.</li>
        <li>In the left sidebar, select <strong>Secrets and variables</strong> > <strong>Actions</strong>.</li>
        <li>Click the <strong>New repository secret</strong> button.</li>
        <li>Add a new secret with the following details:
            <ul>
                <li><strong>Name:</strong> <code>BACKEND_URL</code></li>
                <li><strong>Value:</strong> The base URL of your backend (e.g., <code>https://your-backend-url.com</code>).</li>
            </ul>
        </li>
        <li>Click <strong>Add secret</strong> to save.</li>
    </ol>

    <h2>Step 2: Add OWASP Dependency-Check Action to Workflow</h2>
    <p>Add the following steps to your GitHub Actions workflow file (<code>.github/workflows/your-workflow.yml</code>) to integrate OWASP Dependency-Check and send the results to your backend:</p>

    <pre><code>name: OWASP Dependency-Check

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  dependency-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Run OWASP Dependency-Check
        uses: dependency-check/Dependency-Check_Action@main
        with:
          project: "cipro_backend"
          path: './package-lock.json'
          format: 'JSON'
          out: './dependency-check-report.json'

      - name: Send JSON Report to Backend via GitHub API
        run: |
          curl -X POST \${{secrets.BACKEND_URL}}/reports/owasp?projectName=\$GITHUB_REPOSITORY 
           -H "Content-Type: application/json" 
           --data-binary @dependency-check-report.json
    </code></pre>

    <h2>Step 3: Explanation of the Workflow Steps</h2>
    <p>The above steps perform the following actions:</p>
    <ul>
        <li><strong>Checkout Code:</strong> Fetches the latest code from your repository.</li>
        <li><strong>Run Dependency-Check:</strong> Scans the dependencies listed in <code>package-lock.json</code> for known vulnerabilities using OWASP Dependency-Check.</li>
        <li><strong>Send Report:</strong> Sends the generated JSON report to the backend API endpoint for further analysis or storage.</li>
    </ul>

    <h2>Step 4: Verify the Integration</h2>
    <p>Once the workflow runs successfully:</p>
    <ol>
        <li>Ensure the <code>BACKEND_URL</code> is reachable from the GitHub Actions runner.</li>
        <li>Check the backend server logs to confirm the receipt of the OWASP Dependency-Check report.</li>
    </ol>

    <p>You have now successfully integrated OWASP Dependency-Check into your project and connected it with your backend for enhanced vulnerability management.</p>
</body>
</html>
''';

const trivyGuide = '''<!DOCTYPE html>
<html lang="en">
<body>
    <h1>Guide to Integrate Trivy Vulnerability Scanner</h1>

    <h2>Step 1: Configure Secrets in GitHub Repository</h2>
    <p>To securely store sensitive information like backend URLs, follow these steps:</p>
    <ol>
        <li>Go to your GitHub repository and click on <strong>Settings</strong>.</li>
        <li>In the left sidebar, select <strong>Secrets and variables</strong> > <strong>Actions</strong>.</li>
        <li>Click the <strong>New repository secret</strong> button.</li>
        <li>Add a new secret with the following details:
            <ul>
                <li><strong>Name:</strong> <code>BACKEND_URL</code></li>
                <li><strong>Value:</strong> The base URL of your backend (e.g., <code>https://your-backend-url.com</code>).</li>
            </ul>
        </li>
        <li>Click <strong>Add secret</strong> to save.</li>
    </ol>

    <h2>Step 2: Add Trivy Action to Workflow</h2>
    <p>Add the following steps to your GitHub Actions workflow file (<code>.github/workflows/your-workflow.yml</code>) to integrate Trivy and send the results to your backend:</p>

    <pre><code>name: trivy

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]
  schedule:
    - cron: '31 21 * * 3'

permissions:
  contents: read

jobs:
  build:
    permissions:
      contents: read # for actions/checkout to fetch code
      security-events: write # for github/codeql-action/upload-sarif to upload SARIF results
      actions: read # only required for a private repository by github/codeql-action/upload-sarif to get the Action run status
    name: Build
    runs-on: "ubuntu-20.04"
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build an image from Dockerfile
        run: |
          docker build -t docker.io/my-organization/my-app:\${{ github.sha }} .

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@7b7aa264d83dc58691451798b4d117d53d21edfe
        with:
          image-ref: 'docker.io/my-organization/my-app:\${{ github.sha }}'
          scan-type: 'image'
          format: 'json'
          output: 'trivy-report.json'
          severity: 'CRITICAL,HIGH,MEDIUM,LOW'

      - name: Send JSON Report to Backend via GitHub API
        run: |
          curl -X POST \${{secrets.BACKEND_URL}}/reports/trivy?projectName=\$GITHUB_REPOSITORY 
           -H "Content-Type: application/json" 
           --data-binary @trivy-report.json
    </code></pre>

    <h2>Step 3: Explanation of the Workflow Steps</h2>
    <p>The above steps perform the following actions:</p>
    <ul>
        <li><strong>Checkout Code:</strong> Fetches the latest code from your repository.</li>
        <li><strong>Build Docker Image:</strong> Builds the Docker image from the provided Dockerfile.</li>
        <li><strong>Run Trivy Scan:</strong> Scans the Docker image for vulnerabilities and generates a JSON report.</li>
        <li><strong>Send Report:</strong> Sends the generated JSON report to the backend API endpoint for further analysis or storage.</li>
    </ul>

    <h2>Step 4: Verify the Integration</h2>
    <p>Once the workflow runs successfully:</p>
    <ol>
        <li>Ensure the <code>BACKEND_URL</code> is reachable from the GitHub Actions runner.</li>
        <li>Check the backend server logs to confirm the receipt of the Trivy scan report.</li>
    </ol>

    <p>You have now successfully integrated Trivy into your project and connected it with your backend for enhanced vulnerability management.</p>
</body>
</html>
''';

enum GuideType {
  sonar('Sonar Cloud Intergration Guide'),
  trivy('Trivy Intergration Guide'),
  owasp('OWASP Intergration Guide');

  final String title;

  factory GuideType.from(String type) =>
      values.firstWhereOrNull((element) => element.name == type) ??
      GuideType.sonar;

  const GuideType(this.title);
}

class ScripGuideScreen extends StatelessWidget {
  final GuideType type;

  const ScripGuideScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final guide = {
      GuideType.sonar: sonarGuide,
      GuideType.owasp: oswaspGuide,
      GuideType.trivy: trivyGuide,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(type.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: AppPadding.a16,
        child: HtmlWidget(guide[type] ?? ''),
      )),
    );
  }
}
