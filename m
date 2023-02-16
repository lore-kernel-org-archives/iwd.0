Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F53746E
	for <iwd@lists.linux.dev>; Thu, 16 Feb 2023 14:45:08 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id b1so2419026ybn.2
        for <iwd@lists.linux.dev>; Thu, 16 Feb 2023 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6oi+mNe9q7CCdMfhgzedEvFpmfrVluYT0lS/TbiG+Ng=;
        b=AElqwVjy4pDzfHsLolYYES67u+dSUXrQadlPv7YDjv+lAc/zqlM+ZkXU81XrUdtp2m
         V44gQv7DEHcocVhvhL59ZP6Wne5P+XbgvOzV/1xgcZa0h9Kvu8/lk63Da7NU836trDEF
         /lJEuNcVzHqeSCyiO9+idsYsS5S5dvhT8NCZMZnIzYzIPdut/a6IfwRq9zBj5mqiuhCx
         U0Pg3vHlxqXxmLW2agqEpy/+aoApEiuOcS0/WNKHKWnlK9iasulVe6P/NQXNYwzNf7z+
         9yKEbwyWidAKVeAv8C7vJNNFJ+9XQCEcn57iRdmLdEMPyh+1Bj2KhV5VwTJC3rxAmZhk
         V58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oi+mNe9q7CCdMfhgzedEvFpmfrVluYT0lS/TbiG+Ng=;
        b=JGv0Nr9Me/6AtaBX+0zndIQ/4hejqOObAnlw5D1mlTvMDTyP66ayMa6WW6bp17t26o
         oSHLsytV8Y29mnNR0GeFzUusjUb+ehVKJp1QhN/fDdVfnuBHcV4yQBhqvmCfLHBL+u+6
         OhrYglITaU524OrrzmmBHL83lZXJ0/xduKpkoViyrfkzbxoB23X+a5KAjCETBYm8bnpd
         xMzrdfI04TjX5pl2mfOYxb81jK4BUHwttUVGbNk83o9fKjRudPOqTPidaZfI7SaS5+vE
         L2hog7Ll69HYWsh5K1aZOaPerzhqCJXqqcXctCESLlAW6MSCDcMjOQyMk+SC7p5o0H3X
         8Wrw==
X-Gm-Message-State: AO0yUKU8SNWRGM5IHhpa7xEjatdlIeU12AJ0Ju0dogtXjE1WkjMdMdMx
	BWPRuqAtpMIZ/ifLebCDtu8UrHX2tala/oKCWrHb3/ZlSDQ=
X-Google-Smtp-Source: AK7set9h/CfSYfkCeWthK7siCsF8IUQCWbuyHqmEYL01p2HN+YL+zcoVEW+j4saN8o9+cnqMIHCQ/26FqCkx9SN8DMk=
X-Received: by 2002:a5b:688:0:b0:931:2b11:6584 with SMTP id
 j8-20020a5b0688000000b009312b116584mr647642ybq.591.1676558707474; Thu, 16 Feb
 2023 06:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 16 Feb 2023 14:44:55 +0000
Message-ID: <CACvgo50v+3j1Xshc3DCgSw=R9Xth=2EbjoHUZucdO5Av2t+L5g@mail.gmail.com>
Subject: IWD does not autoconnect after S3, when moving between networks
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Greetings team,

I am seeing an off issue with iwd, where it fails to auto connect upon
resume from S3. In particular:

 - Ensure device has saved profiles for Wifi A (eg. home) and B (eg. work)
 - Connect to WIfi A, device is outside of Wifi B range
 - Suspend device
 - Go outside of Wifi A range and into Wifi B range
 - Resume the device
 - iwd does not autoconnect
 - `iwctl station wlan0 show | grep Scanning` says "no"


Note: The issue is intermittent and I've been seeing it ever since I
installed iwd in mid 2020

Are there any commits which landed recently aiming to address issues
like this? Is there some debug option that I can toggle to provide
meaningful logs for the developers? Alternatively, do you have any
pointers for code-paths I should start looking at initially?

Thanks in advance,
Emil
