-- Tables for structured rule management

-- Table for rule lines
CREATE TABLE IF NOT EXISTS GEE_RULE_LINES (
    LINE_ID INTEGER PRIMARY KEY,
    RULE_ID INTEGER NOT NULL,
    FUNCTION_ID INTEGER NOT NULL,
    IS_CONDITION INTEGER DEFAULT 1, -- 1 = condition, 0 = action
    SEQUENCE_NUM INTEGER DEFAULT 0,
    CREATE_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    UPDATE_DATE DATETIME,
    FOREIGN KEY (RULE_ID) REFERENCES GEE_RULES(RULE_ID),
    FOREIGN KEY (FUNCTION_ID) REFERENCES GEE_BASE_FUNCTIONS(GBF_ID)
);

-- Table for rule line parameters
CREATE TABLE IF NOT EXISTS GEE_RULE_LINE_PARAMS (
    PARAM_ID INTEGER PRIMARY KEY,
    LINE_ID INTEGER NOT NULL,
    PARAM_INDEX INTEGER NOT NULL, -- Order of parameter in function
    FIELD_ID INTEGER,             -- Reference to field (can be NULL for literal values)
    LITERAL_VALUE TEXT,           -- Literal value (can be NULL if using field reference)
    CREATE_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    UPDATE_DATE DATETIME,
    FOREIGN KEY (LINE_ID) REFERENCES GEE_RULE_LINES(LINE_ID),
    FOREIGN KEY (FIELD_ID) REFERENCES GEE_FIELDS(GF_ID)
);

-- Index for faster queries
CREATE INDEX IF NOT EXISTS IDX_RULE_LINES_RULE_ID ON GEE_RULE_LINES(RULE_ID);
CREATE INDEX IF NOT EXISTS IDX_RULE_LINE_PARAMS_LINE_ID ON GEE_RULE_LINE_PARAMS(LINE_ID);