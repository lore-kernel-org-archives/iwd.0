Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6737160
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThttgNH6"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67abd1879c0so155106d6.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882492; x=1702487292; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPPzxEucSIZtIl/CE3iCayxurh5IAMrQwdJ1pIokjJc=;
        b=ThttgNH6xpsOjlJ6DbfYMPwgcS2xWIR/qZK/xDelA9Erlyq3sSzsm5sEqvw0Lv+JNR
         QPhOw7on/I2MAbCA2t07yRmnP3j5G4LEsEJLlhdUTtwkfGuwWi7PGB9cgmcWJkCufr8N
         CchTH0jS+1CNKHwswleHmzk7z5Qjgdy01TQbTv2spfpo1kuk6IciLzernnmo8E4iKoo/
         p5xFuQiIqtKAvME2X6DGQ4s1Y8cQh3XhoCH5ysLz+vgvPQQG6iLxEA3LUhXpGXDTIRNL
         05Mb7zACgClWxza2d9S/FaJ3q1c5fKm4NsUr4I5MopFJ56TyPAGnsSGW8A7on8nNVmvC
         qTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882492; x=1702487292;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPPzxEucSIZtIl/CE3iCayxurh5IAMrQwdJ1pIokjJc=;
        b=imHe2/x/IukihektoyVcGYTU+VnVXmRYVH16TitjuCCd9Dw2nW8t0bmdakguh6FX8b
         TmrnWQs9xnQPRwEtlZVENy1RFwj2rzqXF5UVsJ8oaq9IM3w4mJ3g1JAqffSZBCfJpgoQ
         gS2JMZE+7voVSWrtxbfywAt/m6TyTvDht+1cKnz4+LUZ9g447ZgwXZBmeWWRVgsQ/oUp
         FklYDzdqab9IAN/CpPKHHWoEvNMBnkSbucPpXEHFmVZqXtAHX0z4Hh0iSnQCjS6/jA71
         hYux6LM/u0O1VscAFl93FoxlZOiCZn7W7EE8UQxQLJiv16gYe4OQsi0V+910k+AVY4Dt
         4mGA==
X-Gm-Message-State: AOJu0Yz61U+RbCRlc2qSxMl7IZXbYaUOOp5aoRp9hU1Cwi1x5EF80h58
	2NoesSFbIGP3KOX/LQiXX+Pm4qFop1s=
X-Google-Smtp-Source: AGHT+IH9UNpl5rgSjc1NX50DOOznZKnBcte1P8OJ5wwo0Tp/dHdVsuqJWGr47bPLWM90/yx9awpGig==
X-Received: by 2002:a05:6214:5009:b0:67a:b716:e80d with SMTP id jo9-20020a056214500900b0067ab716e80dmr1567204qvb.82.1701882492125;
        Wed, 06 Dec 2023 09:08:12 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id px16-20020a056214051000b0067aa2d86ce3sm122905qvb.52.2023.12.06.09.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:08:11 -0800 (PST)
Message-ID: <14c4906e-099e-4e9d-90c0-fca8d5eb38dd@gmail.com>
Date: Wed, 6 Dec 2023 09:08:09 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] ft: add FTE/RSNE building to ft_prepare_handshake
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231206150708.2080336-1-prestwoj@gmail.com>
 <20231206150708.2080336-5-prestwoj@gmail.com>
 <620a779d-e694-4057-846d-23e6eea35252@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <620a779d-e694-4057-846d-23e6eea35252@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/6/23 08:36, Denis Kenzior wrote:
> Hi James,
>
> On 12/6/23 09:07, James Prestwood wrote:
>> In preparation to remove ft_associate build the FTE/RSNE in
>> ft_prepare_handshake and set into the handshake object directly.
>> ---
>>   src/ft.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 82 insertions(+), 2 deletions(-)
>>
>
> <snip>
>> +    fte = alloca(256);
>> +    ie_build_fast_bss_transition(&ft_info, kck_len, fte);
>> +
>> +    if (!ft_calculate_fte_mic(hs, 5, rsne, fte, NULL, ft_info.mic))
>> +        return false;
>> +
>> +    /* Rebuild the FT IE now with the MIC included */
>> +    ie_build_fast_bss_transition(&ft_info, kck_len, fte);
>> +
>> +    handshake_state_set_fte(hs, fte);
>
> However, this is less clear to me.  Looking at how FILS and FT uses 
> this API, it seems that set_fte is meant for the authenticator FTE 
> element?  So I think rekeying after FT would be broken by this change.

Good question. Rekeys do appear to work as-is but you are right, FILS/FT 
uses set_fte() for the authenticators element, but eapol seems to use 
hs->fte for building message 2/4, as well as checks that the handshakes 
FTE matches what the authenticator sends in 3/4. maybe this is actually 
a bug in eapol? I think the reason everything "works" is because the FTE 
should be the same between both peers.

We may want to refactor and do:

handshake_state_set_authenticator_fte()

handshake_state_set_supplicant_fte()

Thanks,

James

>
>> +
>> +    return true;
>>   }
>>     static bool ft_send_action(struct wiphy_radio_work_item *work)
>
> Regards,
> -Denis
