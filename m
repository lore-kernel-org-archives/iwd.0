Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3059A18594C
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433855; cv=none; b=twyP59DI3veZHVM/kk5VGT0WtKDjjiPeyJykeXDy1E9sRYpfZzGBjegJamlk7YBdz1X444+nrNycO6DFR0wdBxqAYHDNESXBWpD2cWwyOb5d6gG/y+06DMyWuwP49AWxA35G57l63tOQ+nJEJja1m2pEo569fJOYB3wo3C0kTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433855; c=relaxed/simple;
	bh=NqsWr/fPfK3HeGl9rI5ptDjTI+v3oBxVsxc2DGjvDzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GjrQGjFFn0O7ZWJqNz4ILkuYrXzlJegNFYRYnVR00Sb/IK2zF7aA9tExhqqL6bnfMkgpohgmDOMplrBuS2258Tnweqtn/JqovFDCV4tdGhZorAsMyo3hFTAQD0CbLi5ZznElu5zDznn3Qyj6Co1Fkgvgvl9G+hQpxXYPrHyaEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaQADv95; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaQADv95"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70945a007f0so1819204a34.2
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724433853; x=1725038653; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ty5CmpcLfJ8w0wet6waN1TqYu26HE618P0LAyZtYt6s=;
        b=aaQADv95mS7h8Fe83ZruFa9efTZTisW+yE8Wx9zUy5NO89yeOg8OukfRHVN3dpQr8O
         FrDiD2F/9sNz2qFcrBSbw6LcskZoukSczagJOMXVCpC0CCLkVU9qEq1ZoA3Vlq+jIYtM
         od6vKGW8mOVZ7xLOlszfegVuHfzO5fF78Ye8tU15aHEqb8RedMfJXYy99Flxpvs3+uWo
         V0SF4HfH/CLVhraP3xa+RqF/oAlQ0g4Amr9/jsPlgmmiIeiJJ/eCHfHCF+oDW93MzR/g
         gUA46ZyGXHAvuxn19V2XVjO1Nb8HeMDq63hWEkz5dkROjVgOZ/afCKyk3wBn5VCjnjHZ
         WcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433853; x=1725038653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty5CmpcLfJ8w0wet6waN1TqYu26HE618P0LAyZtYt6s=;
        b=TGSSPmiIKWRPBqsTiGgNWu6SFN5mmr3rDVO+QZJeuLcP72zfv7XlhP+e+rslD7aXi2
         aKt7COuvSYwujeOX4mHkc77BRaszFdRqhT9EOG+iY+QUKI149P1Z0yfcG5obwbJvpm6h
         +95n/Bpm3J/U/dbbc71glkfqolBnUbZD0UwT0s36Qbn4ag3zWYpFm1+7jsBGkWQvRqyc
         KFhkOKdi116IDHTjP2IhC4h4G6AR8X7s2TZMDT4qgHbbitj8t61EmeoqQOUdTSfWMFxa
         MVb/TaJkl/Pq0lZ2210OpuxejcH7izpLJHcoEvPbTaPfkceylh9IU/yzDjBY4Y3/eHSL
         DfKw==
X-Gm-Message-State: AOJu0Yx6c4LxhTsq23MdlxaaiMImUt1W3VYW5zy68seKy/NgSrjmhCHl
	abBQ60dcogr34hsPe/BSXhktddZaKT7so4c+/3xr0vq8Klp8k+EIE5U1Gg==
X-Google-Smtp-Source: AGHT+IF0an2oYm11kPV7ff81QxkOBtlrS03vVFvqVljgv7HA7wSUUSKuqPG1KZPwELMw7f+MBU1ZMA==
X-Received: by 2002:a05:6830:498b:b0:708:b344:fed8 with SMTP id 46e09a7af769-70e0ec2a5ddmr3183740a34.33.1724433853194;
        Fri, 23 Aug 2024 10:24:13 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70e03b5fba1sm724516a34.56.2024.08.23.10.24.12
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 10:24:13 -0700 (PDT)
Message-ID: <688bf80b-5c66-4e6b-8098-c44e4e8995b0@gmail.com>
Date: Fri, 23 Aug 2024 12:24:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] defs: Add defs.h to hold certain global definitions
To: iwd@lists.linux.dev
References: <20240823161848.485685-1-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240823161848.485685-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 11:18 AM, Denis Kenzior wrote:
> This will help to get rid of magic number use throughout the project.
> The definitions should be limited to global magic numbers that are used
> throughout the project, for example SSID length, MAC address length,
> etc.
> ---
>   Makefile.am         |  3 ++-
>   src/ap.c            |  8 ++++----
>   src/crypto.c        |  3 ++-
>   src/defs.h          | 13 +++++++++++++
>   src/dpp-util.h      |  5 ++++-
>   src/eap-wsc.c       |  4 ++--
>   src/handshake.h     |  2 +-
>   src/ie.c            |  2 +-
>   src/ie.h            |  3 ++-
>   src/knownnetworks.h |  4 +++-
>   src/network.c       |  2 +-
>   src/p2putil.h       |  3 ++-
>   src/rrm.c           |  4 ++--
>   src/scan.c          |  2 +-
>   src/scan.h          |  4 +++-
>   src/station.c       |  4 ++--
>   src/storage.c       |  3 ++-
>   src/util.c          |  5 +++--
>   src/wsc.h           |  2 +-
>   src/wscutil.c       |  2 +-
>   src/wscutil.h       |  4 +++-
>   unit/test-util.c    |  3 ++-
>   22 files changed, 57 insertions(+), 28 deletions(-)
>   create mode 100644 src/defs.h
> 

All applied

