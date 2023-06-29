Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF92566A
	for <iwd@lists.linux.dev>; Thu, 29 Jun 2023 07:41:50 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4Qs9Pc5m14z9tkg;
	Thu, 29 Jun 2023 09:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1688024500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljlrUo+za79pGDN2WdleiOieyBemhyA9D3VHFYq6t/M=;
	b=WUvzCT5C7Xtk/w9g1ERdz2kXngEYkNHlc/oXuKGAhQZZdd3/PbP0atDZMgGnxrpHuAyd1Z
	HqWaEvqgjK6jXC7RplI0woXEPgtHXtw6GtBMcYJjELaITaGFk9qLuz760C7CusJ2NSj2MS
	q8dX+845+pT037oM85nGN+77dnEhFB32bH+pH9T6cyYqSEVqZPtd/zAUXEK32xAhjDqKgD
	K2DUTVSGg3QaDMpukapUN5GDED9Vt77Jzzd5eRSNs1exCSKKqvpO6SdQ6K0F5hZGRbSgKq
	QTosr+W1eo0QmEyZmt8JbeUGjsLWjIBmRY1PCbjxxnoS+IM4WJiHlC+K+avhfg==
Message-ID: <5ab35efe-d048-4bfa-45ba-9697e5ca02ac@tavla.de>
Date: Thu, 29 Jun 2023 09:41:39 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: iwd forgets network
Content-Language: en-GB
To: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Cc: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
 <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
 <9d7f0362-67af-bbc4-2cc0-d4f8da123cd3@gmail.com>
 <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
 <2f0cc99c-c547-1150-d667-8fd667be86ae@gmail.com>
 <5448805b-253d-eeb6-33f2-881eb8be2157@tavla.de>
 <303737c5-0191-378f-d164-5434ed0e3c40@gmail.com>
 <d2d75c80-a10a-67fd-07d3-3706bd008881@tavla.de>
 <f36812fc-9165-fde1-03ea-2ba34d1542c5@gmail.com>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <f36812fc-9165-fde1-03ea-2ba34d1542c5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Qs9Pc5m14z9tkg

Does systemd somehow touch or manipulate the directory?

In the documentation I find "the configuration directory specified by 
the environment variable $CONFIGURATION_DIRECTORY, which is normally 
provided by systemd" [1]. Does it only provide it or does it also 
manipulate it?

[1] https://man.archlinux.org/man/iwd.config.5.en

Am 28.06.23 um 17:27 schrieb Denis Kenzior:
> Hi Martin,
>
>>
>> Nothing special. And also, this is not about power-loss. I cannot 
>> remember this happened after a power-loss. I can only remember that 
>> we did a reset of the router which the device was connected.
>
> iwd only calls unlink() in three places:
>  1. storage_network_remove() which is only called due to 
> KnownNetwork.Forget()
>  2. hotspot_network_remove(), which is also called due to 
> KnownNetwork.Forget()
>  3. failure path inside write_file(), but that one only unlinks the 
> temporary.
>
> Since you say you're not calling the Forget() path, it isn't clear 
> what could be causing this.  Having some additional instrumentation 
> either by modifying iwd with additional logging or some sort of 
> external tracing would help.
>
> Regards,
> -Denis
>
-- 
Martin Petzold (Inhaber & Geschäftsführer)

TAVLA Technology GmbH
Im Dau 14
50678 Köln
Deutschland

Telefon: +49 (0)221 / 3466 0885
Mobil: +49 (0)179 / 9220154
E-Mail: martin.petzold@tavla.de

