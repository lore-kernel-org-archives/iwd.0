Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA6209F3B
	for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636132; cv=none; b=D7BP1jzaE5AWz1psw8IWB+N45NW0LgCoDFsz/PK4ZpMD8N5Q8dxRWf7EYkjk69Pfk8agzliBjx2gOEBlgFY1EwoH6IeKZ2t92FCqeCqnvV/TKBuRtVQlVOxgedyS5rt1TV5nfT3I9FHP6FxsVfQZva5E4Xq2SHTPoFwY8kKgg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636132; c=relaxed/simple;
	bh=4DLpiyp1nYGFLeoI84d9JXXQ9szksdmtxzeNczeXObw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LibLwlSHlpv740fBHllql1byBQAukTD4ubr1WDONrMzlq4AsZY2CZfdopRku1QG54jXMnYVIHbKQs/xP5yO99ggkCit1Z4qplF2j82fT0IP4roomovuvavjCwZ7RelUhL7Es5YqPoHV1dBN3amaXvSe1tMDF/t6bs4En3ukTG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=jsaT0ZJD; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="jsaT0ZJD"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XQ0MN4ChRzDv6p;
	Fri, 11 Oct 2024 10:36:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1728635760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxmHGPhE9kHBsi1iFyNsy9I2+3zVzxCDhLMcbma0CAY=;
	b=jsaT0ZJD5F8/nu2Uk/LOr9MJxLmme7SezueLaV39LA7gIsDxw9CzB8uA1T1mPkcHvEnJGz
	3/zM90I643bHT7YS1wTGlB7RYKSVbVa7EKlo9zKA8eiqsoJ6rT4mxwrfti1zdFD3hwa8MD
	i2h3pauKuVkqSBZ60LOlipYN/OdDp6Iye3LQRfXceWgkBVjzB7Uqg3a/4ZUY62yALXP2vW
	XGTQRveZui2sj9JPGMe8JHyCI2p7/5QGjFyQ3+X+n/DVVcoHwQZbFQR3IJATQlzR/T5cbK
	+u2g+8p6PigxHLeHxs4Y9bsPqh62JzoxWN3FHeuM4EPqwaZpkCYnUW9vVlXlcA==
Message-ID: <5ab61b3b-1b31-42e2-8b3b-9c96acfd3c1a@tavla.de>
Date: Fri, 11 Oct 2024 10:35:59 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: James Prestwood <prestwoj@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Denis Kenzior <denkenz@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <74af8f9e-b5dc-41be-998c-45bdd5958bbd@tavla.de>
 <154ebbba-2a3b-4f65-8b21-41dcc93d2107@gmail.com>
 <1fcf76fd-85ab-4a31-8aaf-9d6922ab3a97@tavla.de>
 <b6f570d9-c14d-4e71-87a7-3e7d2c2fd6ca@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <b6f570d9-c14d-4e71-87a7-3e7d2c2fd6ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XQ0MN4ChRzDv6p

Hi James,

Am 10.10.24 um 15:55 schrieb James Prestwood:
> Hi Martin,
>
> On 10/10/24 6:47 AM, Martin Petzold wrote:
>> Hi James,
>>
>> Am 10.10.24 um 15:36 schrieb James Prestwood:
>>>
>>> On 10/10/24 6:20 AM, Martin Petzold wrote:
>>>> Hi Denis,
>>>>
>>>> Am 09.10.24 um 18:07 schrieb Denis Kenzior:
>>>>> [...]
>>>>>
>>>>>> 3. Build IWD 2.22 from source (maybe using Debian sid source 
>>>>>> package?) -> how to do best and will this work with libc6 version 
>>>>>> 2.36? Missing libreadline8t64?
>>>>>
>>>>> I mean this is your only real solution.  There is no 'long term 
>>>>> support' model for iwd.  You either run the latest or you're on 
>>>>> your own.  It is highly unlikely that any of the developers will 
>>>>> look at logs (or attempt to fix) anything but the latest version.
>>>>>
>>>>>
>>>> Why does the following build fail. I did not install 
>>>> 'python-docutils' package because is is not available for Debian 
>>>> bookworm (only a source package). How should I proceed? Maybe the 
>>>> documentation should be fixed then for Debian bookworm.
>>> You need to use an updated version of ELL. IWD and ELL get released 
>>> in tandem in case of any API/behavior changes. 
>>
>> I used for both git HEAD repository (how can I get both in line?):
>
> Sorry, I just glanced over the error and assumed incorrectly. It looks 
> like -Werror isn't enabled (?) so that warning should be fine. But the 
> issue, as you said, is docs related. You could try to configure with 
> --disable-manual-pages

That helps, thanks. Maybe should be added to the documentation.

Now using a cross-build make install does not respect my 
"--prefix=/scratch/root/usr" for installation of files to "share". It 
should install to "/scratch/root/usr/share/dbus-1/system-services". 
Already searching for the correct parameters. But maybe you know why and 
maybe also should be added to the documentation?

2024/10/10 18:47:08 iwd 'development' 'amd64' | + ./configure 
--prefix=/scratch/root/usr --localstatedir=/var --sysconfdir=/etc 
--disable-manual-pages
2024/10/10 18:47:10 iwd 'development' 'amd64' | checking for a 
BSD-compatible install... /usr/bin/install -c
[...]
2024/10/10 18:53:00 iwd 'development' 'amd64' |   CC 
tools/iwd-decrypt-profile.o
2024/10/10 18:53:01 iwd 'development' 'amd64' |   CCLD 
tools/iwd-decrypt-profile
2024/10/10 18:53:03 iwd 'development' 'amd64' | + make install
2024/10/10 18:53:03 iwd 'development' 'amd64' | make 
--no-print-directory install-am
2024/10/10 18:53:04 iwd 'development' 'amd64' |  /usr/bin/mkdir -p 
'/scratch/root/usr/bin'
2024/10/10 18:53:04 iwd 'development' 'amd64' |   /bin/bash ./libtool   
--mode=install /usr/bin/install -c client/iwctl monitor/iwmon 
'/scratch/root/usr/bin'
2024/10/10 18:53:04 iwd 'development' 'amd64' | libtool: install: 
/usr/bin/install -c client/iwctl /scratch/root/usr/bin/iwctl
2024/10/10 18:53:04 iwd 'development' 'amd64' | libtool: install: 
/usr/bin/install -c monitor/iwmon /scratch/root/usr/bin/iwmon
2024/10/10 18:53:04 iwd 'development' 'amd64' |  /usr/bin/mkdir -p 
'/scratch/root/usr/libexec'
2024/10/10 18:53:04 iwd 'development' 'amd64' |   /bin/bash ./libtool   
--mode=install /usr/bin/install -c src/iwd '/scratch/root/usr/libexec'
2024/10/10 18:53:04 iwd 'development' 'amd64' | libtool: install: 
/usr/bin/install -c src/iwd /scratch/root/usr/libexec/iwd
2024/10/10 18:53:05 iwd 'development' 'amd64' |  /usr/bin/mkdir -p 
'/usr/share/dbus-1/system-services'
2024/10/10 18:53:05 iwd 'development' 'amd64' |  /usr/bin/install -c -m 
644 src/net.connman.iwd.service '/usr/share/dbus-1/system-services'
2024/10/10 18:53:05 iwd 'development' 'amd64' | /usr/bin/install: cannot 
create regular file 
'/usr/share/dbus-1/system-services/net.connman.iwd.service': Permission 
denied
2024/10/10 18:53:05 iwd 'development' 'amd64' | make[2]: *** 
[Makefile:2798: install-dbus_busDATA] Error 1
2024/10/10 18:53:05 iwd 'development' 'amd64' | make[1]: *** 
[Makefile:3466: install-am] Error 2
2024/10/10 18:53:05 iwd 'development' 'amd64' | make: *** 
[Makefile:3459: install] Error 2

