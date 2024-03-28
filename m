Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FB8172F
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635332; cv=none; b=q8ETg74euaYedXEO6wbxsat9XhzSJCJD4T/u+roEXZmlsxn/eWDJZoKhNU9tjOSjdYkgOim7QfqPhvR+ZBzr5dl16vo6nHtIN/GR0SNiGnUgIG7JmlLukOrqeaatwF7U/wWsHryQd0Mgo2eb/TDcT6wYnJmLfkc8Si3PlOgNOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635332; c=relaxed/simple;
	bh=P8EGwqEir9gzQD/5bou29vy3A59ucEoShz/5YbMM5rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aj1hyJjq4zBsPHFat1o/vKj/eA2e0UnfEC/P39/WlQEYB51UNVhFqoUcXf+xy1sniWotRH/40jqePwaPJ9oh3Kh4ne9wTagaNEp/ncuV/w9YfJncOfhVAqx1SAckFZWVun7qWZrmPCimm7SNeNtSuU3uVMaae/czDwK9yhT6/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHR9AzWx; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHR9AzWx"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a4859178f1so588780eaf.0
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635330; x=1712240130; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTGgOUthyHQYSX3mpQugZmAFUmXPhVR9MfXypLWcC0c=;
        b=nHR9AzWxsrMNpGg2daCo8w/TL5/oo4bafAqZ4q0rCCnMfRDbRWmY1Mqqit9AwZ4W0D
         8MRn/NlAbeHRh0s6d/RFgbQq9HZ2a+hlCuptL63nZYVXuD1jBs3p6iuxZ11IOmYSCSwF
         /Zf5X8RYniKpTfCz4DN8T6BJzQAWhzf8rCZftNuSbH1evzgWdR+HvTuPLfkRQ5QkAaEo
         Z7h5LNL1QNTRzeXyYqHG+lUSuFKu9uCBh+rLvhagOU1r17wUJL8BA505fRTDppERnMxv
         FJ/KVJTT86mWbSouWqcafXVOpyNtHYKkcHDcHRovTBRf0aDNHqbHO6HiEDYbKl9hfL3K
         mMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635330; x=1712240130;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTGgOUthyHQYSX3mpQugZmAFUmXPhVR9MfXypLWcC0c=;
        b=CMIyJRPNKZn3sVyvJ+cYk3Tb//iA3S564OmgVasCuqEZwsPGT+2q+bjh6gjAWV9iIp
         e/KWJjqdRFB/XyJVqKZC/BNxlboYaRC8NYKFcbg8fZJCp3NFApmBN24EJOZQBZrb0yHe
         tBvyC6eXQ3OQmtiBdze8DhpCZ2G3dtw1ABPQTqi8K3RH/ObEIBWn3faC0HVqRUTt2ecg
         wss7yPCJk0215rTkNVrazJ1cmqYmytotX1uBfNqvIEJ7ReqIcmLnqAfmAktb3JYN9ISi
         4ewNadTWcgKROSmis83LAE3oiGrty4WYqwdG9vZmYIcByaiK54VazSfSY7Y6KJ7ASDUa
         oeXw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6QA0BUodkazO2GXx+WQkSfMISiCYWE3/A3ENrxeaSDqfTHIT/1N/Lidbe4MuEtxSdGW31SJFzAT9QTkoPecdY/4W
X-Gm-Message-State: AOJu0Yw0tp8RM1poL+WR4O2KXejR0+zo7Ul1gUJ3pYPq+zawryvqUmv8
	ioLYa6AxGNGcc4lCqPZMsuVTc3jQfam/hW5MBUkSTJnskSWa5VSl
X-Google-Smtp-Source: AGHT+IH3iDoz7sZZ7hkg1H51KrgAMBZGKs2VKAjmFvhsijgd+psne/zqI9uIlUC6cFicJX7pYwsYDQ==
X-Received: by 2002:a05:6870:b6a7:b0:22a:a710:a193 with SMTP id cy39-20020a056870b6a700b0022aa710a193mr1800902oab.14.1711635329802;
        Thu, 28 Mar 2024 07:15:29 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id fu27-20020a0568705d9b00b0022a0bedad96sm410336oab.12.2024.03.28.07.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:15:29 -0700 (PDT)
Message-ID: <739e21d0-95c5-45ab-8023-d54a128a867a@gmail.com>
Date: Thu, 28 Mar 2024 09:15:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wiphy: add better handling for rate estimation errors
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240328134725.1484257-1-prestwoj@gmail.com>
 <20240328134725.1484257-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240328134725.1484257-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/28/24 08:47, James Prestwood wrote:
> In most cases any failure here is likely just due to the AP not
> supporting the feature, whether its HE/VHT/HE. This should result
> in the estimation returning -ENOTSUP in which case we move down
> the list. Any other non-zero return we will now warn to make it
> clear the IEs did exist, but were not properly formatted.
> 
> In addition HE specifically has an extra validation function which,
> if failed, was bailing out of the estimation function entirely.
> Instead this is now treated as if there was no HE capabilities and
> the logic can move down to VHT, HT, or basic rates.
> ---
>   src/wiphy.c | 34 +++++++++++++++++++++++++---------
>   1 file changed, 25 insertions(+), 9 deletions(-)
> 

<snip>

> @@ -1037,8 +1038,10 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
>   			vht_operation = iter.data - 2;
>   			break;
>   		case IE_TYPE_HE_CAPABILITIES:
> -			if (!ie_validate_he_capabilities(iter.data, iter.len))
> -				return -EBADMSG;
> +			if (!ie_validate_he_capabilities(iter.data, iter.len)) {
> +				l_warn("invalid HE capabilities");
> +				continue;
> +			}

I guess you would want to treat all IEs this way?  Suppose VHT Capabilities is 
somehow the wrong size?

>   
>   			he_capabilities = iter.data;
>   			break;

Regards,
-Denis

