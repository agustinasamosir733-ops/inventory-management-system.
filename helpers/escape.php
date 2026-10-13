<?php
function e($value): string { return htmlspecialchars((string)($value ?? ''), ENT_QUOTES, 'UTF-8'); }
function rupiah($value): string { return 'Rp '.number_format((float)$value,0,',','.'); }
