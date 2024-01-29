Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C68155A40
	for <iwd@lists.linux.dev>; Mon, 29 Jan 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544725; cv=none; b=DJLAKeAMy/C4EuiApECUUCtogKolKn1a+LARe8ID5AM6ztOC5sSCHssmTUERmuqN38XU8zKqA0iwYL7+yEJgt/bZklL4/nAUzjM+E4+CSHHSTblhD48GeAIGfZ4/Jl7+96Zqrsdbu1okbYTlfAxAq+AxR0aGj9Mi3RITD/E61fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544725; c=relaxed/simple;
	bh=lqrf7SHkM1sQqtOkyToFtciRMuHwBDe+BZj4vk52fd0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XIr7Oh1B7efXLLa9xKwdCBCmglR7kmvHLZfvIJ+4CJGLNkTT0BMzGFFK5yH/PYA7vHE4UjJ9M6P31c0yE0CntN/GH+VT6+Bxr0zUKMlpt2rzW4OpeM1FjcUd/3RWmLxE7GatQpzXqyaiw86Nr3JgAHrn2RWBEfy2PS/LdS+rhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMOoJGcI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMOoJGcI"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a35e1b735a9so105290366b.2
        for <iwd@lists.linux.dev>; Mon, 29 Jan 2024 08:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544722; x=1707149522; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H3eJ51fBMLOaxYgOplBe0jRA4jLcFt+Nuimbf+Dokcc=;
        b=WMOoJGcIW8ZCylZHV0S4J6b/cWrixhKipx9TaYoLYdLPsQtxmdmirYSqB1I47aIaTB
         X7C7/c9L5sugJ0MORnn2mrnH2zHnXjMb9z2skP2tozJT43rnDwBZ4uv8Oyqml+Otr72s
         fYjTMO/jNTm4hrEXYCkE+AFsWWA+DiihGi33q/85bciRSHDOOIbQmj9KgfmIzUFqQSBt
         0XgGI9TgYouhFdzoXvjPk57G8ALdI7BA7xSANsY09ZDdZGiQYTvQpeCkCGXIqoCZ7Uw/
         bby1xcxp0Y2zfH6536ZQIgmNbGyjnA7rk4QRyZ3xV+FW5IQr0UYlTByT84fjdk91u7LI
         QrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544722; x=1707149522;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3eJ51fBMLOaxYgOplBe0jRA4jLcFt+Nuimbf+Dokcc=;
        b=oKsLa6tG23bHTDm7JsWRZfSj0wUo8rzgYFIuUpaK4VAhH3kU6r/wSXo+26CfspKeuk
         cPYHWF2w/a/kBCY4AnNhIgbjYM5Vb1VOQ44GmEE8KQy/dyZUcxA+j82ST9/MV7Sge1sp
         14VNzBbrnBpkKNkTLSP+C+g9R1fWFXEa6uTZTia63QpLUdJHamIxfvh7UsaZDW9iqvYm
         4Jc5QHw9N9o33fSNNyGTIQsmrxKQgeYa7XATInoVNdy4+G7WBZtI/2hRS/jnovdvZHjV
         QLN8idithv/soLlzuD/Z99KwukuL762s+A0w6/x41j18SOAkppiHRV57Nbrl6/3whGx2
         h+ww==
X-Gm-Message-State: AOJu0YycZ6Fikf5UB+P/1rvdV981mTZ59qjmH6rIPLJm/rDLmz4FEYZF
	L6pFB7PhvL+60QEoEMwBLd/VTanhIZX+Vljdqpw3fxVdL0OUoMh4b7/4YLyS82IF3BLtCRYtkSB
	4o7xLKEuw0A0u0Td7E7vqwtnRui9TCRHmUgVwOw==
X-Google-Smtp-Source: AGHT+IHxls6PbTsAAuvF4IUwKSpx4HZFGCADTk2HNga/G9Mr8BONvhl3zZu1+dpdPwtAVjAuIAjVtVexd9gLclxmnxI=
X-Received: by 2002:a17:906:7f90:b0:a2c:3596:b0c1 with SMTP id
 f16-20020a1709067f9000b00a2c3596b0c1mr5053027ejr.75.1706544721113; Mon, 29
 Jan 2024 08:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Mathy Vanhoef <vanhoefm@gmail.com>
Date: Mon, 29 Jan 2024 17:11:49 +0100
Message-ID: <CAFXAJYz3nVT2i3AkoBrCeh+GqkNDrFmriJtfHt=as6j2x4J6jQ@mail.gmail.com>
Subject: ap: only accept message 4 after receiving message 2
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

We found that when IWD is operating in AP mode, it doesn't verify
whether message 2 was already received before processing message 4.

I've included a candidate commit message and patch below. My mailing
client might destroy the spacing, but the small patch should
illustrate the possible fix.

---

When operating as an AP, drop message 4 of the 4-way handshake if the AP
has not yet received message 2. Otherwise an attacker can skip message 2
and immediately sent message 4 to bypass authentication (the AP would be
using an all-zero ptk to verify the authenticity of message 4).
---
 src/eapol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index bad4bbb7..3ce14d5c 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2092,6 +2092,10 @@ static void eapol_handle_ptk_4_of_4(struct eapol_sm *sm,
     if (L_BE64_TO_CPU(ek->key_replay_counter) != sm->replay_counter)
         return;

+    /* Ensure we received Message 2 and thus have a PTK to verify MIC */
+    if (!sm->handshake->have_snonce)
+        return;
+
     kck = handshake_state_get_kck(sm->handshake);

     if (!eapol_verify_mic(sm->handshake->akm_suite, kck, ek,
-- 
2.43.0
