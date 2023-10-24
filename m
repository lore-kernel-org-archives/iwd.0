Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811332C85D
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBrmnOx6"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-584042a01eeso2754931eaf.2
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698157568; x=1698762368; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihPPjpqCLG4dB/BLe7w91W9uOJBfPphLiiJ1mUa9RgM=;
        b=CBrmnOx6Ybn3ejOWSHOuiyiGZraa8shQxAlZUcCZSImxCrD0dElBYnNSD+iygjcW3h
         eUiJbPQQ/W9uNQ42XuMmPFk5BiRXQ6G5k+pgcSuggWqxcGCeqpeXVSidiJnRBfp/l1EK
         MmJ2p9tXoOyA9nuDHCV3viBMMj99k1IAURntOfubQzVaiW67EDoxccAA2v0PQU1CZabP
         XhPh+ot4i0NvW/vlDe3/TK9Jj5zEPmyOLSC0mgmdihnvBbMoELHZOJeYmUZAK/FRsfOy
         UhnFDt/4BGyXGvMez8aWK1S2k5o0kSGVo4znsGQU2DwJRjzd/x+Xq2r60fAHl4SI8DCL
         39Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157568; x=1698762368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihPPjpqCLG4dB/BLe7w91W9uOJBfPphLiiJ1mUa9RgM=;
        b=doGpC4/CqZ6fGH/j09hETFgxipAldEAvFVnwrf2HqAdG+3mLTVMNmBI8qqjJlzbKc4
         H2xCKIMpS2da8B7PBEc5xJ8mH3aowfLbFoEssW9sexfTT2taIJuCHwb5TXU+pwyxR/SD
         IM3lvh/T8TLU5C7lA8FznveSCKEzaDbV79veOHSBWGr0byT18uRqcByip/semhqsDaE/
         WE8/O9q6XPPrylbxcgia6j8tg4lMpcEWzbzMCY/lGTyO0ezL26Nt9mbqiO+E/cdRimtR
         myPZzHoA749+G4cVBWasP3fCT7KbLZqK1BfaY2fVuEKsrf2AjZC6gWAx8xkBBPBHgBw3
         mGCQ==
X-Gm-Message-State: AOJu0YxOviJq6jGFsER3sHtujOnKO38rLHln/RQsfTkeQxEfNseb78Wu
	7rTCmn/qg5T0DSpU2nH1Umk=
X-Google-Smtp-Source: AGHT+IEn/IK6tquq1lci5c1PJu2U1HcZ6HtEbcrpMBZBRIRnrN699azehRJM3qJl0lylRGmC6Ib2Bg==
X-Received: by 2002:a05:6820:1aaa:b0:57b:6d88:4cb3 with SMTP id bt42-20020a0568201aaa00b0057b6d884cb3mr10830477oob.5.1698157568478;
        Tue, 24 Oct 2023 07:26:08 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 6-20020a544186000000b003af5f6e40d7sm1945180oiy.15.2023.10.24.07.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 07:26:07 -0700 (PDT)
Message-ID: <3d2c3d76-e08c-4d71-8a72-7193dd51cbfc@gmail.com>
Date: Tue, 24 Oct 2023 09:26:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
Cc: iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
 <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
 <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
 <29094eca-dcf8-4234-8afc-13d37db8450c@gmail.com>
 <9e12bf94-aa83-4fe6-b045-8dab45b264ae@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <9e12bf94-aa83-4fe6-b045-8dab45b264ae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 10/24/23 07:32, James Prestwood wrote:
> Hi Denis/Simonas,
> 
>>
>> Now the question is, how do we make sure iwd is estimating the HE rate if 
>> available?  Also, how do we tweak the estimation logic with sensitivity 
>> numbers (obtained from a spec sheet, or through experimentation) for specific 
>> hardware being used.
> 
> Trying to catalog different hardware performance and act on it for ranking is an 
> impossible task :)

We can actually have our own hwdb of sorts for this.  Hardware sensitivity is a 
differentiator (think marketing), so should be fairly easy to find.  Also, it 
doesn't have to be absolutely perfect, just reflect the hw capability a bit more 
closely.

> 
> The only simple solution I can think of would be to add a user-option for some 
> threshold RSSI in the rate calculation. If set and the RSSI is below the lowest 
> of ht_vht_he_base_rssi just use the last index (-82) (and maybe force a 20MHz 
> channel width?). This would at least let the rate logic return _something_, 
> albeit maybe not accurate. But again, those RSSI thresholds were sorta made up 
> anyways :)

They are not made up, they're direct from 802.11.  But again, they're the 
_minimum_ specified sensitivity.  Hardware typically does better.

> 
> So you could set:
> [Rank].LowSignalRateThreshold=-90
> 
> Any RSSI between -82 and -90 would use -82 for the rank calculation. No idea how 
> this would play out in practice, but its at least simple and not tied to any 
> given hardware.

No, I was more thinking about:
/* Added to the rssi value prior to looking up in the ht_vht_he_base_rssi */
SensitivityFudgeFactor=4
/* Width penalty */
SensitivityWidthPenalty=0 (3 today)
/* NSS penalty */
SensitivityNSSPenalty=3
/* Same as SensitivityFudgeFactor, but for HE */
SensitivityHEFudgeFactor=10

Regards,
-Denis
