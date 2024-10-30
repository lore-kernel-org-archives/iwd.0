Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8619CC24
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730315990; cv=none; b=hJihWlEbfu6m2LrL/4+W124/LobkqmpXjDL/6YQI6O7gG9zbpTe5negcWnv5vIVCHis1h4NFSdMqHANww9gPIzpMEIA/HKZUyjLHVshouE6ew1+TaTzQ0xCMQUQTbQqIaApmx3DrosUlJXmSgsf0sZ+b549uHfxEmCYNjRIU9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730315990; c=relaxed/simple;
	bh=AJCbGAKCauwxymJ7w1RI94eIwgyBxfq25WIfUgvpuak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm3iswS2nddMGW3UHEIR9twxO7O9N2CFbAMi60Py9B0oHWY0sWLd7O8/OJS1DcABml1S6lhpoENe2OJ7hXrP48WPLh/ptGfXN6PNhZ7Bp+dT2Vm88YH1TCwfAwK6g0IHAy5J08kfSfz6ZeapB0ZSJGHCy1FRq2kI2aPgipu1jAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=wf1tj7P8; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="wf1tj7P8"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4XdxlF4bcHz9xGf;
	Wed, 30 Oct 2024 20:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730315977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhrVWci/nJwi6cu2hiLlqJAPWjv/6J10Kgr9Gmp1h1c=;
	b=wf1tj7P8Zb/5mv7q/I7Qw8dS1M6HZm9o8bX80ruELfxhK4cfhKJBfXAKFAIpxkTeOflx3I
	wYeTeTymJeWqp7IpkpV8y+clhsUbuMh4i2xe8OrHktKXxT4IOEizXpEPpg1OLPdLcFFs8a
	9/qzjJS78YQTggMRhdpRTjQb9GaQ1D5YITOmMuOgIWa0FEwRSYlqt/GwXolI6J8ySjC1v5
	5VJksZVgant+/1C8rFIC8K/+beyTu1iPwSutZLjSrIz29cDf5gVYjZ/8dq/UmqNNpPoI9b
	mJsxbrxm5BQ0UJ8Y2nJ5adr71mgJHWGbsWhCDqDC6aV52zF0EJc/png1ldOqeg==
Message-ID: <afddc14a-0806-44ea-a2a9-a6cdda694a1d@tavla.de>
Date: Wed, 30 Oct 2024 20:19:35 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <19272307f90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <69cc8b13-e6b4-43c5-8ba3-7877a75f0581@tavla.de>
 <717feddd-8756-4271-8c05-5ef46ff9e8d2@tavla.de>
 <e27b082f-15eb-412e-b1a5-292b17080cc4@broadcom.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <e27b082f-15eb-412e-b1a5-292b17080cc4@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XdxlF4bcHz9xGf

Dear James,

I am still investigating several things. Also it seems the related 
roaming environment is quite a challenge. Maybe if we manage this one, 
others won't be a problem.

Am 12.10.24 um 13:51 schrieb Arend van Spriel:
> On 10/12/2024 1:06 PM, Martin Petzold wrote:
>>> 3. If you say roaming can be handled by firmware (driver?) OR daemon 
>>> (IWD), what is the best approach and how to configure it?
>>
>> This question is still open for me. In general the question, will 
>> brcmfmac work with the laird firmware and IWD stable (really good) 
>> also for roaming?
>
> In general it is best to let firmware take care of roaming. You can 
> try using the module parameter 'roam_off' and see how well IWD takes 
> care of roaming. I have never used IWD.

What will happen if I use 'roam_off' to switch off roaming in firmware 
(I understand roaming is done in firmware and not brcmfmac driver)?

Would you expect it to work? And IWD taking over as it should?

Additional question: Could there be any power_save enabled in my setup?

(btw. some online sources tell the parameter 'roamoff' and not 'roam_off')

Thanks,

Martin

