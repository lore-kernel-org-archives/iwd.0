Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448A2FCC02
	for <iwd@lists.linux.dev>; Mon, 25 Aug 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132342; cv=none; b=KNmCP5y5266mCHD062koVD7DQsqJ5YtVD8q2UiLOtzpsertHeGEgxOlMN0tWq243odP/NDDdTXjSW5bM0SzqWarV3pH49f314E7W+ddA4k6UfrwkZKCbNT3bcgDIfF3FUheDUeG//Q9iHrAsW43XtbDzAElUXnnUT0cy2EaqfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132342; c=relaxed/simple;
	bh=5y7UuddgbiQG6Nn2rrQeFD5hGp2xNNUs13tUD6/WW+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLgWK/F/SDDYjvATPT2w0Y+UcHuQU6Rcazva08Y8fqiXoU1fCt09SjRyIuFqnJqaPFYM8Gqlzu/pUzwe1WrDBih92BRnHMm/Fg7fWPmbbLKByq4apUKP4afh+51DlO/CitxTa9w00VcdbGYbuBDz6yg8xH7NubRqMPuiwrU+eW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbQk+KWJ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbQk+KWJ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70a9f5dfa62so43340536d6.3
        for <iwd@lists.linux.dev>; Mon, 25 Aug 2025 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756132339; x=1756737139; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvv8P2Javnxihf7Dk2vjPFiMMpC8KpGEG24Y4z/H3cw=;
        b=XbQk+KWJruRKCg7GTCBh5nTxQo5QsY9744hAW65tAd9pujBCY1nt68bE0ZQ0sPeCNw
         rMs6j07c8gUYEdJSFX0664fYXYkRPCDUpnWaAippcScdxvvpI81sUrmyV4GoAa//eqKD
         trr1NbDV0ljLsTL7ivL9JAGFgJqIW9KCwajaugMmNs55WdZBnswUcMbHxsMsVUMa8arT
         7uK1V3RiAUO9i7bKa5nDlsC97FKeVqUgG/vWb1NNJRUbyf94POjCB/4FR+L3TVg3tzEW
         QA2dhzKd5DikiLE61j8tO7uZ1TgxMQQCmdCUof1C1PUH3ULlcfrlVKNBMPSMUPEhyKiP
         5R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132339; x=1756737139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvv8P2Javnxihf7Dk2vjPFiMMpC8KpGEG24Y4z/H3cw=;
        b=vWqhTTxk5BP/G0ef9ojpjM7lq09Htll0Z92VpAUUtnehmBAbza8TCHeckoMMLA+4k7
         JODzcoYntBZKYIIDtm2vHpozmKbXcaS8SF1BHdPN4o9/2zWnc1Gb918VjiwYYAAJ/2ZF
         8Pq7IrYTxqNvjhtmy1YGBOqTmb1mCyi2MQmkxDfaPNnfywk4D65OevC1tcGqNS+Ob5NG
         /RBANgJCdqi8jH0UUr8UQ3cPHD1f+IsvPJHcZCeQ18sGi1MKbdYfRtO9WWOAcdTvACHU
         XbEgcVGjSs01wAZ7ZI5uy+GQW/928i+YNHblThSJYKR42kPefl+zXDp4nggT5t4J8Qsy
         QSqg==
X-Gm-Message-State: AOJu0YyfxoD1S2UHX5Ze3CPlCvPm4hRsBGOGQcNYgF2zdnnmpyEjhNPr
	MrF0lGREN659kZhre0koFZRgKLdiSKZQsnBKyBKrxcNjkMFliIppQWrjocgeBg==
X-Gm-Gg: ASbGncuENd/ekpVkZAd8kEx+q5B3wg/94iY7ShAodEYqVhD0HklRmIpW9TziZws/Pdi
	qwfrih+WQdJGyiuZ0FTe1VyW6z6u9mu3tAMtxNj895choBYjUW/eJd/pHh8bDRLt+2j1goOU6bT
	l0ig9n87inQCXY3Rz7BmiGW+3W21dQoSBqjAWnlWh1fJ9FrJ0gTZWBTTCK9IQ58rdxNjSWIIRpm
	mMrSzTvj9yQ/vbFs0brP2w1g46VRHjr+c+P7tMEG7XQwfEdR2bJkgGZyHAeAsP75gEShR+3iPU8
	X7YdaanSzuQ5EVzwYz8WwOVlB+jx0obAaBLPCBMDFXF8lG2MEpnIHMGJNmgSXzWSejQpDuHkdaG
	ReadKjDMarFxJW5spAEWdSluiCg==
X-Google-Smtp-Source: AGHT+IGaJW8fg40ni4Ky7WWTrb0kxQt5aLKdVBINUEMdPqF6FGBxsoQD35HGf956adCETQBSLaBTMw==
X-Received: by 2002:ad4:4eae:0:b0:70d:93a4:c0db with SMTP id 6a1803df08f44-70d9709810amr149184046d6.7.1756132339015;
        Mon, 25 Aug 2025 07:32:19 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da717edf6sm46871856d6.32.2025.08.25.07.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 07:32:18 -0700 (PDT)
Message-ID: <ab281abb-6d8f-47e3-97c1-877d759dcabf@gmail.com>
Date: Mon, 25 Aug 2025 07:32:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] vendor_quirks: add two new vendor quirks
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <20250822195118.271122-6-prestwoj@gmail.com>
 <E8A1EBD8-1747-4961-A27B-CBFE37065866@holtmann.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <E8A1EBD8-1747-4961-A27B-CBFE37065866@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 8/23/25 7:46 AM, Marcel Holtmann wrote:
> Hi James,
>
>> VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST:
>>   When a BSS requests a station roam it can optionally include a
>>   list of BSS's that can be roamed to. IWD uses this list and only
>>   scans on those frequencies. In some cases though the AP's list
>>   contains very poor options and it would be better for IWD to
>>   request a full neighbor report.
>>
>> VENDOR_QUIRK_REPLAY_COUNTER_MISMATCH:
>>   On some Aruba APs there is a mismatch in the replay counters
>>   between what is seen in scans versus authentications/associations.
>>   This difference is not allowed in the spec, therefore IWD will
>>   not connect. This quirk is intended to relax that check.
>> ---
>> src/vendor_quirks.c |  5 ++++-
>> src/vendor_quirks.h | 15 +++++++++++++++
>> 2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
>> index ccfcb444..e005ba3b 100644
>> --- a/src/vendor_quirks.c
>> +++ b/src/vendor_quirks.c
>> @@ -34,7 +34,10 @@ static const struct {
>> uint8_t oui[3];
>> uint32_t quirks;
>> } quirk_db[] = {
>> - { }
>> + /* Cisco Meraki */
>> + { { 0x00, 0x18, 0x0a }, VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST },
>> + /* Hewlitt Packard, owns Aruba */
>> + { { 0x00, 0x0b, 0x86 }, VENDOR_QUIRK_REPLAY_COUNTER_MISMATCH },
>> };
> are you sure the name is Hewlitt ;)
Whoops, will fix in v2
>
> Regards
>
> Marcel
>
