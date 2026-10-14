# ttc-mcp over HTTP, behind a secret URL. See docs/mcp.md, REMOTE USE.
FROM python:3.12-slim
COPY pyproject.toml README.md LICENSE /src/
COPY src /src/src
RUN pip install --no-cache-dir "/src[mcp]"
# /data is the one folder it writes: the personal layer, and beside it the tokens.
ENV TTC_HOME=/data/home TTC_MCP_TOKENS=/data/tokens
USER 1000:1000
EXPOSE 8765
ENTRYPOINT ["ttc-mcp"]
CMD ["--http", "--host", "0.0.0.0"]
