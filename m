Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDC1FAC23
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535182; cv=none; b=LHU/3qRowPCcgG9n7RfWRpCE+qndDDtnJSGm8LVUiG9maWqixHWxeHn/H0k5BdYxij4W/Kn2S2uAqas9oppXboAzsS8ixqPiR5AvQg3ciOmdrrx6wWvioabfZx2EqcFPOwPABKDgJA7TBoOmYrwx0O92oPRmMOSwmO7Z2FFfrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535182; c=relaxed/simple;
	bh=MmOZi6WNjqyNZdM7vfevb+TxevqD8pB8jIFExEE1H+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RV6cSzTtsnUFMjcf5EWJKWKCdf021YEw+b+fu3/aSc2urJyx0hHlLBCsR3QLEcBajAiqJfivkPqpcGbSf0rsiZJqMS58mwbiOKXNVOE7SIpl6T9bYTMHnMerNn8OYSE5XuwFS4rEvFcGv4dTwNjoiEwEViBssL129iQ0KLzC5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LLoG6ukj; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LLoG6ukj"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5fa17a79dso2484072b6e.1
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729535180; x=1730139980; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OV4HGVP5uk3Tpo6/n7ZUivolFx8FLO0qyYIndcIBtS8=;
        b=LLoG6ukjmLhcz94N95mMrKj+5aCQy/0Ffho0lBT+L2x95puI2n/W9PU4q8pHF4pTQR
         s1cvov4a8O4qLOMStP6NrLhjqRcQUq3PwL5nXbC5uNPmOo0Jj981P66FBfPsgFW4vKwp
         T5MZ3L0EoVv073mqoLiOxKVLrQEs/A05o7v60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535180; x=1730139980;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV4HGVP5uk3Tpo6/n7ZUivolFx8FLO0qyYIndcIBtS8=;
        b=F2DwM6KsjO7nae6bFEVHqz/PCGBw+nljkKVKLpIndPa/0014x9HElEJiW1ayvZG5s5
         XgLwSUeFTcqIeubI0Gls5skwbpnTO19CpwkIwjV2Nyn+tgJgzmSIuZ0zGeRfmGnPuJTc
         dzhGrZc5/gU3fKpSRkMSLtzHvvTTN0p3uJ4b9phMKeIXsefzz3/Wiyah4J9Jaa4GsaS8
         a9QsvGWOlg5KmHQ4SI6Hz09vcFNmZnRYqBngcuEu4+DAYkj5c47ZuFy74AAftP/2vyaW
         /KcmZ7edVdexCuomckAGOiDzaM6Fk7srU5suXcSLIjU8uFRYXfcYA7111Y+FbaBJ8BVx
         f3IA==
X-Gm-Message-State: AOJu0Ywz6JGehEZJbHZLC9KueMiEA6cINjiGoZ04rT5e/IqcGUXjRUW7
	1Dvd8g2D7I5YOP0ClazXQBKsWuyHAnmMu27A2rLNZqAVDeaxaKRTDxRbJ1aElQ==
X-Google-Smtp-Source: AGHT+IE07V51gF38FyRniB/hPx6Rx8vwMONZ5TdbUt0+oooR0SEKDZEnHNPBybGh7osyyoWxffnP8w==
X-Received: by 2002:a05:6808:1782:b0:3e0:4f9e:b6ad with SMTP id 5614622812f47-3e61c90f817mr892748b6e.22.1729535179699;
        Mon, 21 Oct 2024 11:26:19 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb62fsm3383371a12.14.2024.10.21.11.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:26:19 -0700 (PDT)
Message-ID: <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
Date: Mon, 21 Oct 2024 20:26:12 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
 Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
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
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/2024 7:40 PM, Denis Kenzior wrote:
> Hi Arend,
> 
>>
>> I have not seen patches for OWE in brcmfmac. Looking at the supported 
>> ciphers:
> 
> OWE is an AKM.  It still uses CCMP/CMAC underneath.

My bad. Always confused by those concepts.

>>
>> Supported Ciphers:
>>   * WEP40 (00-0f-ac:1)
>>   * WEP104 (00-0f-ac:5)
>>   * TKIP (00-0f-ac:2)
>>   * CCMP-128 (00-0f-ac:4)
>>   * CMAC (00-0f-ac:6)
>>
>> The error message seems to match with the above.
> 
> I've never seen support for OWE in brcmfmac mentioned.  OWE requires 
> CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) to derive the 
> PMK, so iwd can't support it on FullMAC.

I have never seen any mention of OWE either. Regarding CMD_EXTERNAL_AUTH 
support I recently posted patches on linux-wireless list as RFT. There 
has been zero feedback and so I assume also zero interest. In order to 
use CMD_EXTERNAL_AUTH the firmware needs to advertise "sae_ext" in fwcap 
debugfs file. So if Martin can check that, ie:

$ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap

Regards,
Arend
