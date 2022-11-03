Received: from mail.pappacoda.it (mail.pappacoda.it [128.116.175.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE079C1
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 21:32:08 +0000 (UTC)
Received: from [192.168.178.107] (orino.pappacoda.it [128.116.201.23])
	by mail.pappacoda.it (Postfix) with ESMTPSA id 395653D4FB;
	Thu,  3 Nov 2022 22:31:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pappacoda.it;
	s=20211226; t=1667511120;
	bh=CxkZIO12moZfl4+1pI2oFExfPOyQ2v+BIj5Zc1WRs2g=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=Kt4Gb/Zwnl7edYYF+hDGURh0LTtV7yoy8OTx4kKU9g+qLHN3pZ5b0gwzK5wXWNWml
	 rb4eBCSwK3vTxBD1fsGT2Sp45weWx5XlI44b3rvKPD1KQHdre7PJYuN2+gBMaR55Fo
	 jBNIuIfsGuDJTWwWQCmDXMi1r1+68pmOtjBbxmN0ELQzsCRAzRycxeCP0UQWUC6j/l
	 XmeLcmKyjn7wkMubQUrqZglN8LwFJiMwLIl2MVIUpLCSsehvC0QbUGL5RBg6vmxNzj
	 xb5+UdfO9T6m4DD98OqNJ6dlL7GyDjFQ98+RA5fjy7lhkS7Vzg+vLAwLU8ohAycGO5
	 wJ4PL4yiuOFRw==
Date: Thu, 03 Nov 2022 22:31:53 +0100
From: Andrea Pappacoda <andrea@pappacoda.it>
Subject: Re: [PATCH 2/2] doc: document global MulticastDNS option
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Message-Id: <5TJSKR.MEMQ5IPV9F42@pappacoda.it>
In-Reply-To: <5aca9b77-5c66-7744-8e33-a0578b645408@gmail.com>
References: <20221103105639.8289-1-andrea@pappacoda.it>
	<20221103105639.8289-2-andrea@pappacoda.it>
	<5aca9b77-5c66-7744-8e33-a0578b645408@gmail.com>
X-Mailer: geary/43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Denis, thanks for your feedback :)

Il giorno gio 3 nov 2022 alle 14:21:28 -05:00:00, Denis Kenzior 
<denkenz@gmail.com> ha scritto:
> Right now, if no setting is provided, then we do not invoke 
> SetLinkMulticastDNS() at all.  If we were to send 
> SetLinkMulticastDNS() with an empty string, would it just apply the 
> global resolved defaults?  In which case, should we simply default to 
> using an empty string if the setting isn't provided?

Unfortunately I don't know much about D-Bus, but I took a quick look at 
systemd-resolved's source and it seems that this wouldn't work.

As far as I understand, when no link-specific value is provided on the 
D-Bus interface, resolved sets LLMNR to "yes"[1] and mDNS to "no"[2]. 
It is possible that I have misinterpreted the code though, so checking 
if this is actually the case could still be worth it.

[1]: 
https://github.com/systemd/systemd/blob/6c83054c0133eb53245e479d71589dceff76cf74/src/resolve/resolved-link-bus.c#L514-L515

[2]: 
https://github.com/systemd/systemd/blob/6c83054c0133eb53245e479d71589dceff76cf74/src/resolve/resolved-link-bus.c#L562-L563


