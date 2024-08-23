Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C341C69
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433670; cv=none; b=ViH1hhUl2i/b0TjhdrSc43oGM1ivKOtLeyEJVcR3uzdyIszGW/02nnFdMH1njNeZzZM0jY7lsj6SddePQJyHezx1otsCzlow+W5u+nPlLsAvZw11nhy/smdWb2EMDbNQ0/+RKmqIDJTrcZqz9Udc6ZvYrcm2TIs4eUJybNftpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433670; c=relaxed/simple;
	bh=BmElsIZxI71B8W9OGDCxJ33IyMRR3mRT3UmK0y5VFxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=spkWGS8miBk4UjEciqpKWufvhVr5Ecy8dtDfMCpnG7xwlX2Apji06FBlLO/4GiTW8VMDOKH7WUJcYtfGPflJRcDYC6/d6HhztOszWr43lsjKG7n13dH8ZpToDq9zpeVSjO68v0XpveDfZb/YroQqWa487A3sekfN02qiE3eSw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB0ZyJ/k; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB0ZyJ/k"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44febbc323fso11591261cf.1
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724433668; x=1725038468; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OMdOt8u4DMqWcwuNlbJ5mczkLP5GQDKc/8/Lo5dk/sg=;
        b=RB0ZyJ/k0I7JA7/6XNsvTPw1P1U7YnsRYb5ZCEo7eDs4Gw1aurxslO+SJPT75SuSDx
         KgfqgotzoEXyNs7URD3yl9xRK3QFXl2Obd0uvHe5yKQBWda3Zp4W8tdSQEL6eEUWNbgN
         +iIyOOCcmL4B9es9OZ3ueBPmjxmdt+W0MJCwaerT2HSL3MGsGyMMp70MZhaTpJZQ8LG+
         VxBVCNLj3uBGH4cDwAwSR7RVRaZf+z2c/vtESjLqNl6xQXFgDsI9KnxR3277uWx5iNyQ
         b9L0VZXD6oeoh64ekSiCpY8aYE3jkQjAJmgGdJU8ixiwmUDFeWcmoG20QTHrXID4kpJU
         eH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433668; x=1725038468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMdOt8u4DMqWcwuNlbJ5mczkLP5GQDKc/8/Lo5dk/sg=;
        b=VEE7+T0PxlIRNrT2gHCz7uMSD0MXxieKXFf1qHnDXQQh8SwLjT8WtRFLwzgykXx37s
         YBls0AsxUNIyTSqcO+YFNErFyBke20v3WgiXCtN4orRW2W4v85DCcPGZV/2yT8R5ALz6
         7KP0R9rLKqzhWx97VvZcGUIdEGBLgqRvxxgSlx0u4+8TZzN/jj7gfWC/eO3wu/bHWZK8
         w9j9Hz18e/vrabocVHT1Deo+TQu3OgG7Vj82E73RT13l5PYxmbsO2lfvoyhDnZZh9Pbf
         MJEX/G7yvm3Th3YBUG1zYmkDrediVYhkltuX4oIH7Le3mC8X+epyF0bHRZQcqj9daPSF
         4VQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZr+5UKNDUaHi2XdBhNNjAxpknAEAFlROb9/bU9e+HIWWI4sOK7Uunnl8dv1AoMvFZ5HE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0Qk09i5530GHSwt7dT41tCv6jopN6B9bJu/1qtENX63r7cvfE
	7xevyxeTPmhbs5ayXOJhupsXa/pO0h456VWfkNMpEsoMhsClI2d8
X-Google-Smtp-Source: AGHT+IHMP8pNxugsg9aRee+UJOGsMhHDeca+D5Q8ROLAC2nenqkI9c0csNmlcXYZn2m6OKF8+a7BiQ==
X-Received: by 2002:a05:622a:124b:b0:454:e7e5:79df with SMTP id d75a77b69052e-455095f1a4fmr33379851cf.9.1724433667769;
        Fri, 23 Aug 2024 10:21:07 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe199422sm19148931cf.74.2024.08.23.10.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 10:21:07 -0700 (PDT)
Message-ID: <2dd33cf6-8dcd-46bd-a262-1a4b4c42a35a@gmail.com>
Date: Fri, 23 Aug 2024 10:21:05 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] defs: Add defs.h to hold certain global definitions
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240823161848.485685-1-denkenz@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240823161848.485685-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 8/23/24 9:18 AM, Denis Kenzior wrote:
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
All 5 look good.
