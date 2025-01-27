Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86284039
	for <iwd@lists.linux.dev>; Mon, 27 Jan 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994898; cv=none; b=b+FfGnTQeJccqXN74je+xTkluwos3pDlBlOd2rW3e+Yzk9ZATyspmZrUMlV3lSI3/yHsXcUp70sYGnOjdJaV9R8pbVra28VBMG6n0G/klAmtQgiqY6baVmn87MjZdKqhV9rfzmnDvhGpdV22Wrog6OnjBQCpViDlM3HRbHDBbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994898; c=relaxed/simple;
	bh=HyqAV0ZmrZDYEZrqlGJeURe45vb3HHOMSud7tRrnThw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0aIRSyOFBP9LlQuKksUFJr75v2/PcGICY7VKX6AmfYzg7ypX+2P2t5ywergHPX6cBYW0qFOkK4rhKnMoO5WLNzRiGP65s5hbZrvTtUPGxTFx7+uOgpe0JdF9N2zFGpLuxmius5OR3m/IG+F9gJ5V+FDb33Dih6bRyGINUydJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3OzqLXQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3OzqLXQ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so6142809a91.3
        for <iwd@lists.linux.dev>; Mon, 27 Jan 2025 08:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994896; x=1738599696; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzMBIfWU5bdCa8KvZhr5IOhKmecNioUCNYFQARrmR4Q=;
        b=l3OzqLXQwT5/v9Whjupcuj7uvVLXOzvHG8EXOIh/8P41ufPYsLHzzlwPNxH5J+ojyB
         nHMBEEPYRmx+fEHf7SexLjnc10p64y49fC4BXd+51remwwnc2bwY9jmncnIZ2DWVapF+
         NbICX/ivv1BgzVAaDPSGukEAIeu5Fld4Wmc2Tmj79ebDMNgFucggPXNj2CteV8zvc8pu
         RQWpeviKu+xqm4HUS4rXcFg/pKsGtsGw+PIz/3VEzyXutODxLPQ9//WBy/2Nz7UEJ/mt
         Kgh36rQ4J1kDuwv96qNqbce8IRLDQqizDgfGRUlD/CIjXmG2CDKGParHwAi7r54e6IVy
         D8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994896; x=1738599696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzMBIfWU5bdCa8KvZhr5IOhKmecNioUCNYFQARrmR4Q=;
        b=pQFwcTji1EIX3paa6tcDJtaY+RQhilmeQ0OA3zeFvKv57T3PB6jIFgRIAfetdL+THD
         Q3H3ZJWFNumUqNHlMKkdWxhlcqhx+sn02J1Ejn0KFVhS2KSggunFXWznbtSg/AgTdKkG
         4y4G8k4C7gQWFQr24DPgEhA1hLYU8yvThTv187IxRZdI1r7ChUawAKlN6OMFruhqLENh
         cMwkYZfdnPvRD1RR8WLu8VoBTIrv742ekM1/jNtlBolntYxDi32B8J74sdg/p4q42C/u
         Y6yv7caaSK5vcAbBbxevTvH+Lmz/XYCAqRMsr8LkpFJICG1ExZjtN4nflms345slFbhb
         GyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBHCdqGyWe4egAbn3uGaYAYTawbgkmCa43tYOCMLASGWnBHN4E0rJu76o6gOb3gBaoF3U=@lists.linux.dev
X-Gm-Message-State: AOJu0YxlPxkEEkBVDpporKTvEZut9+2DwjUdwYeEr5OX+WPTuH7PKgbx
	ZrtJ0h2hjEudiy76RzthoL9YpQMY27/nWXuG8nl7S2bTzlNiUKkjstMuHw==
X-Gm-Gg: ASbGnctQDNiSimEuH1L05nXMSUtYkQRxc2Y1gEB06I0EQJM2sTRnDqRPYTMHeB39jG4
	LpewZVCepmJYs8XXIuUvATN9BTog961nsnHrr3aoAGzXhMz4P71+tRjBcy/lz/i7d53jAhWvHo6
	qCj99WovoVQtM02qCFuXEW+UbdBvHRUe5/CdMCDAW+ovd6m97Bku9yaywc0hFirTDuxiY5Ch6gy
	F+kBZwg/L07C5K258FWDjg6Z9/0f54bZ1nZcbhaOxGQXbaznvcTfajbJg17OHC/lX0oLsoFTP0z
	9/aJ4G7W
X-Google-Smtp-Source: AGHT+IEfAmHL/mNaYh90IltnSfEG93T6rOMZCHrww6ODJd6/rbOOE2L24wz3nfsCizStfj5wCaIajg==
X-Received: by 2002:a17:90a:c883:b0:2ee:7698:e565 with SMTP id 98e67ed59e1d1-2f782c6fdcamr58340773a91.8.1737994894905;
        Mon, 27 Jan 2025 08:21:34 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb194a5sm7433314a91.44.2025.01.27.08.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 08:21:34 -0800 (PST)
Message-ID: <76b2f0b5-641d-43e6-9c6d-4073fbc61dd8@gmail.com>
Date: Mon, 27 Jan 2025 08:21:31 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: KeithG <ys3al35l@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
 <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
 <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com>
 <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
 <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 1/27/25 7:09 AM, KeithG wrote:
> I just tried this and it connected 2x once from a saved key and a
> second time from a new key.
> Will continue testing and let you know, but this may be it!
> Thanks so much for all the support.

Would you mind testing the latest RFC patch I put on the mailing list? 
Please remove the DisablePMKSA option in main.conf with that patch. I'd 
like to see if PMKSA will actually function with brcmfmac without 
external auth, or if we're stuck disabling it entirely.

Thanks,

James

>
> On Mon, Jan 27, 2025 at 8:29 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Keith,
>>
>> On 1/25/25 8:37 AM, KeithG wrote:
>>
>> <snip>
>>>> With wpa_supplincant, before the AP sends the 'PAE:', we get this
>>>> which is not in any of the iwmon logs with iwd:
>>>> < Request: Set PMKSA (0x34) len 92 [ack]                              14.561627
>>>>       Interface Index: 3 (0x00000003)
>>>>       PMKID: len 16
>>>>           05 cb 9d 0d 9a c6 7c 42 77 b5 d2 23 f0 62 f7 4d  ......|Bw..#.b.M
>>>>       MAC Address D8:3A:DD:60:A3:0C
>>>>       Unknown: 287 len 4
>>>>           c0 a8 00 00                                      ....
>>>>       Unknown: 288 len 1
>>>>           46                                               F
>>>>       PMK: 254 len 32
>>>>           35 28 07 cb 94 de 82 e7 0a 5c 73 d3 e4 1f 88 ae  5(.......\s.....
>>>>           74 84 82 66 86 8d b5 aa 79 cb 75 d9 75 8d da 3a  t..f....y.u.u..:
>>>>> Response: Set PMKSA (0x34) len 4 [0x100]                            14.562171
>>>>       Status: Success (0)
>>>>
>>>> Is there any more info or help I can provide?
>> Looks like the only difference between IWD working and not working is
>> when it includes the PMKID. This is due to the new PMKSA feature which
>> looks like it requires some extra work on brcmfmac (using SET_PMKSA).
>> Try disabling PMKSA in main.conf with:
>>
>> [General].DisablePMKSA=true
>>
>> This should hopefully get IWD reliably connecting.
>>
>> Thanks,
>>
>> James
>>
