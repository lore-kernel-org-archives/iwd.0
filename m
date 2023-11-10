Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64714008
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.de header.i=@kloenk.de header.b="VIoF7eTu"
From: Finn Behrens <me@kloenk.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.de; s=mail;
	t=1699611365; bh=mBdugStAh1M8NsVMoZ9seHvUrvfRd7WCXWoknF2yZ1U=;
	h=From:To:Cc:Subject:Date;
	b=VIoF7eTuA256AkZ61WDOWcYA4vYJKOySFN6veGDgmUvjR3M1c5WFGSlWomXylvTkw
	 dRxY4ErKvqHy+VwC0sYwRfbiLdUblCyUsLl37/ZQ8IONacMfO8hVzWbSDlAkMdNlsV
	 97Ae8JTaOA0KWlllHsQmErq43d757IWAsht/bsq8=
To: iwd@lists.linux.dev,
	secure@intel.com
Cc: dev@leona.is,
	Finn Behrens <me@kloenk.de>
Subject: [PATCH] client: display_completion_matches add 0-byte check
Date: Fri, 10 Nov 2023 11:15:58 +0100
Message-Id: <20231110101558.30639-1-me@kloenk.de>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that enough space for newline and 0-byte is left in line.
This fixes a buffer overflow on specific completion results.

Reported-By: Leona Maroni <dev@leona.is>
---
 client/display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index 8b06ff58..64125934 100644
--- a/client/display.c
+++ b/client/display.c
@@ -633,7 +633,7 @@ static void display_completion_matches(char **matches, int num_matches,
 	l_free(prompt);
 
 	for (index = 1, line_used = 0; matches[index]; index++) {
-		if ((line_used + max_length) > LINE_LEN) {
+		if ((line_used + max_length + 1) >= (LINE_LEN - 1)) {
 			strcpy(&line[line_used], "\n");
 
 			display_text(line);
-- 
2.39.3 (Apple Git-145)

