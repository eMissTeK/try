ALTER TABLE READ_PROGRESS RENAME TO TMP_READ_PROGRESS;

CREATE TABLE READ_PROGRESS
(
    BOOK_ID            varchar  NOT NULL,
    USER_ID            varchar  NOT NULL,
    CREATED_DATE       datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    LAST_MODIFIED_DATE datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PAGE               int      NOT NULL,
    COMPLETED          boolean  NOT NULL,
    READ_DATE          datetime NULL     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (BOOK_ID, USER_ID),
    FOREIGN KEY (BOOK_ID) REFERENCES BOOK (ID),
    FOREIGN KEY (USER_ID) REFERENCES USER (ID)
);

INSERT INTO READ_PROGRESS(BOOK_ID, USER_ID, CREATED_DATE, LAST_MODIFIED_DATE, PAGE, COMPLETED, READ_DATE)
SELECT BOOK_ID, USER_ID, CREATED_DATE, LAST_MODIFIED_DATE, PAGE, COMPLETED, LAST_MODIFIED_DATE
FROM TMP_READ_PROGRESS;

DROP TABLE TMP_READ_PROGRESS;
