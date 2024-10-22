Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1A13AD26
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622868; cv=none; b=DaVcjn0jysmXP34b/THBxDlNG1ZYMNJgVwYf2plHeaLPe2ZTVQYUg0Oh2gz9i1B4/botWxyPeBuaTGh+TGQkfR/DQBSpI3WWYLMkRT9IG9pyrKh2BO9HIO09Zbi9Paq4Pl3I9aet+K2YV0G6IxVQGGSeJi7jkFucEbo+R559BOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622868; c=relaxed/simple;
	bh=FhJEtB5GgnE26x7H6DCUjVaAD7+np/h74lXgTuD7jF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngJaNUE36trR1hAQDcb7xGh41lNKz1XCE94o+zpzwoOqL5LAU8cKl0KB+wbsjjFQ0cZXAZG22L+EY3DcJZ5tC+5izDbJoABjLsxTRrdPapg2+G4/WbX7U/vx5NV9gKiP7oC9lxGhnNQnafaS55PlEnnpwai19sxFrVZxP5grShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=CAtPSDoD; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="CAtPSDoD"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4XY1Pz20qnz9x04;
	Tue, 22 Oct 2024 20:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729622855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+KVFPouWxpSiqWb8aExNEu2x2ss07QNGOrxfVoQ768=;
	b=CAtPSDoD0qX43hxtYfdJntscV9x6malwo5TsKw31mf46ks6jwDkts9clWbsXm0kZnIQqIp
	vrVyG3MG+T6R0MfJgpH0pjaOiVlWM9MM9cZa9fzdr63wbtbZc7ngstuQNbI0XdNnG64yJ8
	xmn30rWEisgImNnQjLq51jjkVr2jfri4PCtqXcB7NkpqktXZtryQ2WSKwkKYxgAWbqBqBH
	d5O/66VEveKibqqUavflKkJdibqmWfK8PSo4sxC+e8ja5C7fC728OkAQDPBe3vNee9Eaow
	7k67hr2xh+paFM4cwVt7p13BTvRgLxHvl6TJO6DVkcjsoVdakL4U/MqYLGW+Rw==
Message-ID: <d5d5357b-cc90-47fc-b7bb-7f25d99972fc@tavla.de>
Date: Tue, 22 Oct 2024 20:47:30 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, KeithG <ys3al35l@gmail.com>,
 James Prestwood <prestwoj@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
 <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
 <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
 <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
 <f1f2b4cc-367b-43df-a637-b380d979e11d@gmail.com>
 <6170a2a5-dc7d-4182-8b83-1b43b93c4f46@tavla.de>
 <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
 <b3b58b08-da06-4485-a980-edcc42d2453c@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <b3b58b08-da06-4485-a980-edcc42d2453c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XY1Pz20qnz9x04

Hi Denis,

Am 22.10.24 um 20:44 schrieb Denis Kenzior:
> Hi James, Arend,
>
>> errors out as its unsupported. I don't believe there is any way for 
>> IWD to check if OWE is supported by the driver, and we just assume it 
>> is (Arend, maybe you know of a way to check this?). It appears that 
>> what you need is a new IWD option 
>
> Indeed, there's no explicit way of checking supported AKMs.  The 
> NL80211 API isn't much help either:
>
> /**
>  * DOC: OWE DH IE handling offload
>  *
>  * By setting @NL80211_EXT_FEATURE_OWE_OFFLOAD flag, drivers can indicate
>  * kernel/application space to avoid DH IE handling. When this flag is
>  * advertised, the driver/device will take care of DH IE inclusion and
>  * processing of peer DH IE to generate PMK.
>  */
>
> Perhaps for FullMAC, iwd should start checking for 
> EXT_FEATURE_OWE_OFFLOAD presence, and if not present, do not use OWE.  
> Too bad no upstream driver actually sets this bit. Unless... maybe OWE 
> works with other FullMAC devices and we'd break things for those...?  
> Kernel folks really need to chime in here.
If you provide a patch for kernel driver or IWD, I can test tomorrow.
