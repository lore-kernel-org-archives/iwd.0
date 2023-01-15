Received: from out-107.mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB8B20E7
	for <iwd@lists.linux.dev>; Sun, 15 Jan 2023 17:28:24 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boula.in; s=key1;
	t=1673797983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHFMCGS8C8b/FPzowd4Gu5C7eVYGI+ZLA+LSB4Z9kYo=;
	b=vIV4UQXMvfKJLx+DJGngxWTLw0OlbCFPrfjmqLsQ9lPcM9Y8J6g8doPxY9e+Aa3A8dhn45
	zME3pTaIqv6316ihTOQzZHNLxIg51+AtEodwdvFot8pJ71OKskxZMIUxVEMEPX/5b/oXsY
	+CESrpgKP5FjCRK47ZCO3Jnp4vNpz0mHqkHEmtzynKITHhXhffhQDKUkwpgpuiz4A8wU2S
	zzxO0jE/cUF8bJnaZ4Yoe/aEn7zmjFkVi/BULpX9O0ECanbfd0vc2olIZTKjnkws02SM+z
	yK4+8oSZc91eSR7HbpvLcstflIvQ5tOIHrOJKOSieCQsp4OXnfaKVlBHdLghYw==
From: Kevin Boulain <kevin@boula.in>
To: iwd@lists.linux.dev
Subject: Re: iwd fails to create device
Date: Sun, 15 Jan 2023 16:53:02 +0100
Message-Id: <20230115155302.14317-1-kevin@boula.in>
In-Reply-To: <2fec88f46974c051e5b4c277b50d2ae88c2fe5e5.camel@gmail.com>
References: <2fec88f46974c051e5b4c277b50d2ae88c2fe5e5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> This looks very familiar to an issue we fixed with dual-phy cards, but
> this isn't the case for you. Its as if your phy is being detected
> twice.

It doesn't look like the OP has followed up on this but it seems I have
a very similar issue. It appears that when iwd (2.0) starts and the
kernel (6.1.3) reports Bluetooth/iwlwifi stuff right after it, iwd will
see the same interface twice and my wlan0 interface won't come up.
Restarting iwd fixes the issue.

> More info about how to do that can be found here:
> https://iwd.wiki.kernel.org/debugging

> Maybe someone else has a better solution, but you could create a bash
> script (e.g. /usr/libexec/start-iwd.sh):

I'm not sure it will help because iwmon's capture appears to start a bit
too late (but that's the first time I try to debug something like this).

Journal entries are from the first to last iwd log and I anonymized all
the logs as described in the wiki but I can resend the complete files in
private.

Logs manifesting the issue:
  journalctl https://pastebin.com/z7iCvYAP
  iwmon https://pastebin.com/Va4XEEDs

And for comparison, when everything goes fine:
  journalctl https://pastebin.com/DJAHgZYE
  iwmon https://pastebin.com/iRHF9Wd8

I'm happy to try with the latest iwd commit or another kernel version if
it would help. It only takes a few reboots for the issue to happen.
