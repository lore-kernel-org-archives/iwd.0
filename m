Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288CB21313C
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894938; cv=none; b=gxwV3aWKJ9jrG1EitAMtjED6ZMSudVq39jGQOIxXnA+m2jhO3b8dAGgimZYxzTjUj2iXLnobUQM8QUhRqrCOpuc44qswhBAAThi3e4Vwt7dgcR4GpQ707+2P/mLJuxyE3LXnrt4sIQFwouCu7A8/6/M1d0WhI8VbpuHa8V/q3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894938; c=relaxed/simple;
	bh=Ut+wsJuGO8rxSUqimZ6bHe7K16X4UKvBuXPOH523A6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSf3fqPyLN9etFsiEooz8VMtunlIiGJ6kJCCJWIdHjNlRq9jk/Re+p1KuVbiIzkR4qyjklknLkdGMD2+acaDn91LMa9yiz8aFylZGuOdFFLlCSIzNquhmYu0mYhLg9XnlOZNFnzBBF+L9vinvdERi9kKm340b6qAAPzDiQLDtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=Z2O0bev7; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="Z2O0bev7"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4XZy2B14hzz9wfl;
	Sat, 26 Oct 2024 00:22:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729894930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2I9AJK41XFRPFsOn7Vd14+4o7f88ktujek0uw59FQE=;
	b=Z2O0bev77nBYAbSlNw2TrlyHw5tQ45RQ+lC7i85aCIBfu5xVNvwCgio0NFKXjU+rvDfRJy
	nVE7ddoPhofiD7FMiv+NAKsk9DUiatHUXI4QkwGNQiT0rus7Fp5QAddBdfqkl+7RwN7vCx
	3G6Zb2LJVftrUIFpKWN+mvXEG2s47OaA/DxOHPuzSkpVZW1PuKxfYzSgD1POjNKVXABFS7
	u8yqJtkTndZpKXbZTVLfGE1Q7xCljPB4z3xQE+KjCfwVtAjxjHBLkFZakuw5FlOG8vb+RB
	IVV3xsCZFsRnfviUt+PfPWSk21zNPKlRyyIu2c05taRTK6FG4d7wXNWh+h1O7A==
Message-ID: <0f83e2f7-eb3c-41a6-aa43-e0c0b89cedef@tavla.de>
Date: Sat, 26 Oct 2024 00:22:08 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: James Prestwood <prestwoj@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
 <57826e6a-8466-4e45-8906-6cb15968bcc8@tavla.de>
 <e19e7527-9cc1-4c84-95ac-dcb39f836d58@gmail.com>
 <78437e50-e6b1-4965-bd03-776fcf3c9801@tavla.de>
 <a64c4733-9011-448c-ab75-8916ff339ac4@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <a64c4733-9011-448c-ab75-8916ff339ac4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Am 25.10.24 um 17:17 schrieb James Prestwood:
>> [...]
>> I'm quite sure this is related to your BSS / AKM patch. It happened 
>> on a client here after an image upgrade to this version. I have never 
>> seen this before.
> For WPA2 those patches _should_ have zero effect. Based on your logs 
> the behavior here is entirely different than with OWE. Before the 
> connection to the OWE network was actually failing (failed within 
> brcmfmac). Here IWD tried to connect and got no event back from the 
> driver. To know this without a doubt we would need to to run iwmon and 
> see the communication between IWD and the kernel.
>>
>> Also, I have debugging for BRCM enabled (CONFIG_BRCMDBG=y and 
>> CONFIG_DEBUG_FS=y). It sounds strange if there is no output, even not 
>> before.
>
> Maybe Arend has some idea of why userspace could send a CMD_CONNECT 
> and get no associated CMD_CONNECT event?
>
> The fact that even manually connecting didn't work after this happened 
> tells me the driver is "stuck". Did you try cycling the driver with 
> modprobe?

There may have been a problem on my side, sorry. I will come back, if I 
see this again.

Thanks and best regards,

Martin

