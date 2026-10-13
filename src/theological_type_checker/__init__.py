"""A type checker for theological and canonical claims.

The rule base (``lp/``) encodes a small typed relational theory (the
Grammar of the Icon) and an authority graph over magisterial and
theological sources. ``engine`` solves it; ``suite`` is the regression
suite; ``server`` exposes both to a language model over MCP.
"""
__version__ = "0.4.0"
