Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB001754B
	for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651211; cv=none; b=SSbaHRkIj0Bd+F4r/GHVGIQNJBIMi9Vjx8P5l1whiyPxQ18uCvbw2nfkJC1hbyftoeC196gxxe01Foe4HvChWcI1dUewEumqr7aRYJwBjaaZ2gQSetDoATZ2VvQ5VormuZL+9uYJoqR7lYNdQzTCac7xzA+oawdpeBDc6lPc4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651211; c=relaxed/simple;
	bh=oeQ4MHHXqxtzV8L+XSLKMbqldjR0V8ePMDaa8LJSxSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FRTbfSIonL7BXMlazjG9h5uCZH95774txaMjPV779uXSyLPOD5zWt3jcfcJSi/YMLqmVZIN+YVL9kg1kS26YV/zTJbwVYYAzXJ4TPIUEWDpvp8F6LP6KejqMFYb/JSnRdH1CWzC7Cb7t6oC64s+Xn8mkMZP1/Xgqr2QNnUeEaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=ShR0hq5s; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="ShR0hq5s"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4WSK951h2WzDsNC;
	Mon, 22 Jul 2024 14:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1721650793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wPUF6BP/hvLyeDadd9BZTuT/XRv3IQpkMb1QCfauZQ=;
	b=ShR0hq5srnM4bfvkFqf8ElKsmHVd3pmjrYz//mne4vm8pYOT0uODGtWJJbA8GV/sORT80a
	jgZ0MSLkJzTYgnn6iIDgdU6wxDZV3VffRPvE4DSsMxzjj08Hc41pvA2IOCIvs6PZoMi72E
	2or6CRvwSpWumqOLvr231xVNxYQaIcEsdL9KG5hvDrTKu42hOi+VNCm37xpNUbhZLsfZ2U
	EdB4EzHAgR4JH+Oz52lOnBkwxd5RwPfl4FzAw43tkroAmPU4KJ3SzYLSBwwfp1om2R0czI
	tnEaCIjEJ3mce7+Me8UhUebBHOUKYwGPpngocQTVStCXuKhoIcL7xKvO1OumlQ==
Message-ID: <11b269eb-fed4-4aee-b829-5b87a2bd19d0@tavla.de>
Date: Mon, 22 Jul 2024 14:19:51 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: No re-connect using systemd-networkd and IWD
From: Martin Petzold <martin.petzold@tavla.de>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Cc: Denis Kenzior <denkenz@gmail.com>
References: <e088f7e6-c455-4635-9edd-a51c619654d4@tavla.de>
 <c8cc4e80-1f3e-4393-8e21-54804628f5b0@gmail.com>
 <8c7ff992-2f03-4e4f-97bc-36eab3727d44@tavla.de>
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <8c7ff992-2f03-4e4f-97bc-36eab3727d44@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Am 02.07.24 um 09:52 schrieb Martin Petzold:
> We are not 100% sure, but maybe these "[Scan]" and / or "[Blacklist]" 
> options actually solve our problem. I would recommend these options to 
> everyone having this re-connect problem using a fixed device setup and 
> single WiFi network.
>>>
>>> ##### /etc/systemd/network/20-wlan0.network
>>>
>>> [Match]
>>> Name=wlan0
>>>
>>> [Network]
>>> DHCP=yes
>>>
>>> [Link]
>>> RequiredForOnline=no
>>>
>>> ##### /etc/iwd/main.conf
>>>
>>> [General]
>>> UseDefaultInterface=true
>>>
>>> [Network]
>>> NameResolvingService=systemd
>>>
>>> [Scan]
>>> InitialPeriodicScanInterval=10
>>> MaximumPeriodicScanInterval=10
>>>
>>
>> This will just make iwd scan more aggressively, without fixing the 
>> underlying issue.  Aggressive scanning isn't really necessary unless 
>> you're moving through your environment very fast.  You mentioned that 
>> your devices are stationary.
> It does not seem to re-connect. Thus, maybe it does not detect the 
> network anymore. Just now I can't say if "[Scan]" or the “[Blacklist]“ 
> options help.
>
These options improve the situation, but the problem is still present. 
As we see improvements, we are quite sure this is a bug in iwd 1.14.

Best regards,

Martin


