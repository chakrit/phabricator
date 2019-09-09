<?php

// See: https://secure.phabricator.com/book/phabricator/article/configuring_preamble/

preamble_trust_x_forwarded_for_header();
$_SERVER['HTTPS'] = true;
