# MCP Servers Included

This plugin includes 7 pre-configured MCP servers that enhance Claude Code's capabilities for Python AI engineering.

## Included Servers

### 1. **Serena** (`oraios/serena`)
**Purpose**: Semantic code retrieval with symbol-level understanding

**Capabilities**:
- Understands code at function, class, and variable level
- Multi-language support (Python, JavaScript, TypeScript, Rust, Go, 8+ languages)
- Semantic search (e.g., "where do we handle authentication?")
- Efficient indexing and memory system
- Symbol-level code intelligence

**Use Cases**:
- Understanding project architecture
- Finding code by purpose, not just keywords
- Discovering patterns across codebase
- Efficient code navigation
- /primer command for project context

**How it works**: Serena creates an index in `.serena/memories/` on first use, then provides fast semantic code retrieval. Ask it questions about what code does, not just text matching.

**Usage**: Use with /primer command or ask "Serena, where do we handle [feature]?"

---

### 2. **Memory** (`@modelcontextprotocol/server-memory`)
**Purpose**: Persistent memory across Claude Code sessions

**Capabilities**:
- Store architecture decisions
- Remember API endpoints and patterns
- Track common project patterns
- Maintain context between sessions

**Use Cases**:
- Long-term project knowledge
- Architecture documentation
- Pattern memory
- Decision tracking

**Usage**: Automatically stores information. Reference past decisions with "based on what we discussed before..."

---

### 3. **Context7** (`context7-mcp`)
**Purpose**: Access up-to-date, version-specific documentation for any library

**Capabilities**:
- Always up-to-date docs
- Version-specific information
- Works with thousands of libraries
- Python package documentation

**Use Cases**:
- FastAPI documentation
- Pydantic v2 patterns
- Pytest best practices
- Any Python library docs

**Usage**: Just mention "use context7" or ask about library documentation

---

### 4. **DuckDB Operational** (`mcp-server-duckdb`)
**Purpose**: Query operational database

**Capabilities**:
- Execute SQL queries
- Analyze application data
- Access user records
- Query transactions

**Use Cases**:
- Database analysis
- Data exploration
- Operational queries
- Schema inspection

**Configuration**: Set `DB_PATH` in `.mcp.json` to point to your operational database

---

### 5. **DuckDB Analytics** (`mcp-server-duckdb`)
**Purpose**: Query analytics database

**Capabilities**:
- Performance metrics
- Usage statistics
- Business intelligence
- Data analysis

**Use Cases**:
- Analytics queries
- Performance analysis
- Usage tracking
- Metrics reporting

**Configuration**: Set `DB_PATH` in `.mcp.json` to point to your analytics database

---

### 6. **Linear** (`mcp-remote`)
**Purpose**: Linear issue tracking integration

**Capabilities**:
- Create issues
- Update issue status
- Link commits to issues
- Query project data

**Use Cases**:
- Bug tracking
- Feature planning
- Project management
- Sprint planning

**Setup**: Run `/mcp` to authenticate with Linear on first use

---

### 7. **Notion** (`mcp-remote`)
**Purpose**: Notion workspace documentation

**Capabilities**:
- Search pages
- Create documentation
- Update content
- Access workspace knowledge

**Use Cases**:
- Documentation management
- Knowledge base access
- Content creation
- Team wiki access

**Setup**: OAuth authentication required on first use

---

## Using MCP Servers

After installing this plugin:

1. **Automatic Activation**: MCP servers start automatically when you use the plugin
2. **Restart Required**: Restart Claude Code after plugin installation
3. **Tool Access**: MCP tools appear in Claude's available tools list
4. **Configuration**: Edit `.mcp.json` to customize server settings

## Python AI Engineering Use Cases

### Serena
- Understand project architecture quickly with /primer
- Find where specific features are implemented
- Discover patterns across the codebase
- Navigate large codebases efficiently
- "Where do we handle authentication/validation/errors?"

### Memory Server
- Store common FastAPI patterns you use
- Remember your Pydantic model conventions
- Track project-specific architectural decisions
- Keep context on database schema decisions

### Context7
- Get latest FastAPI documentation
- Check Pydantic v2 migration guides
- Look up pytest fixture patterns
- Find Strands AI framework docs

### DuckDB Servers
- Analyze ML model performance metrics
- Query AI agent conversation logs
- Generate reports on API usage
- Analyze error patterns in production

### Linear + Notion
- Track bugs discovered during development
- Document API design decisions
- Link code changes to feature requests
- Maintain team knowledge base

## Adding More MCP Servers

You can add custom MCP servers to your local `.mcp.json`:

```json
{
  "mcpServers": {
    "custom-server": {
      "command": "npx",
      "args": ["-y", "package-name"],
      "env": {
        "API_KEY": "your-key"
      },
      "description": "What this server does"
    }
  }
}
```

### Recommended Additional Servers

**For Python Development:**
- `@modelcontextprotocol/server-filesystem` - File system operations
- `@modelcontextprotocol/server-github` - GitHub integration
- `@modelcontextprotocol/server-postgres` - PostgreSQL database access

**For AI Engineering:**
- `@modelcontextprotocol/server-brave-search` - Web search for research
- Custom MCP servers for your AI model APIs

## Troubleshooting

**MCP servers not loading?**
1. Restart Claude Code
2. Check that npm/npx is installed (for npx-based servers)
3. Check that uvx is installed (for Python-based servers)
4. Verify network connection (MCP servers download on first use)

**Authentication issues?**
- Linear: Use `/mcp` command to re-authenticate
- Notion: Follow OAuth flow in browser
- Check API keys in `.mcp.json` environment variables

**Performance issues?**
- MCP servers run on-demand
- First use may be slower (package download)
- Subsequent uses are fast
- DuckDB servers are lightweight and fast

**Database connection issues?**
- Verify `DB_PATH` points to correct database file
- Ensure database file exists and is readable
- Check DuckDB file format is compatible

## Learn More

- Official MCP Documentation: https://modelcontextprotocol.io
- Claude Code MCP Guide: https://docs.claude.com/en/docs/claude-code/mcp
- MCP Server Directory: https://mcpcat.io
- DuckDB MCP Server: https://github.com/modelcontextprotocol/servers/tree/main/src/duckdb
