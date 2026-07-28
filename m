Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449E46A61B
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264008; cv=none; b=g/qWf4n6hjrBpb96sfjn2rnu9VM+yH9lzY4oRJVCLH84k0c1jrRmzgNgHp6RwCByGvgt5JgBnVNZiulT7PHmo6uI00O4UCvdGGAeed/5yRD0I4zalMOYRQyUtR88BVB24/zXEmOQlBkO6D70e9gS95uQEN1Es+eT7eZETdCtyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264008; c=relaxed/simple;
	bh=aiICWEFQ4ei+C91l1QygMMRVatjKhcKuhaHdABlPNss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9bxRfjh5Md/+bWA0rlRWxdn6Wo4Nst7CyiGXUZtulAHSRj/vqHgq6xjApkyF0vFTJkv+SVnmgsMqGy8RIXqJzr2tpAcOj3wfIW86MODgkXm9BAvJlTHRFVahKCFy+DPZJ6MkM9KayTS1s0cfq197CGiOSGE0oyw5CIfFN+S7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL/7ik1A; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL/7ik1A"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8453427d3f4so155370b3a.3
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785264006; x=1785868806; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXPYNgkBbBOzccdS9vd9UccAUc83gJW1f3zGdxtn284=;
        b=ZL/7ik1AzQt3NzncFfj52VBTfMaHrxEcsD7gPBTKNsjPXAJcLC99uHFrQw8Xr+hdS8
         2xUybVg0Tx+9tUk6xuH+juOariXmfoBhgDL7xCQR0cSjVhN9go3aaYLUgroJJ2+tn5Yl
         5sgZezLaWkkhWaZ2EqqAVgMMhw24wbelt6daftdqeXCncJ7DxaTXwtXAdDhV5zS0RniY
         ljoCJLRuxU6EVI6Zlm72O5W+re5Tp1Mk0Do6KBuOC04anjoEXRvpQSDACQDhJEou7M/t
         bb2csPXrJVIDYu/pMCKC7Iih9JDqnncy/sfYVHpAeX0hV181ECJUWtnMlWs9+wYUwgNP
         +gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785264006; x=1785868806;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXPYNgkBbBOzccdS9vd9UccAUc83gJW1f3zGdxtn284=;
        b=dVSR4OE23n0b1N8JjXlKKJJBZjZP877rzu7CshDeJmEgWLaryJgqlawwnJ68Wlkht7
         SmhY+vkkpu5H+vJ5ufYlfTVITDUcUqvfgMzegV9/PwH+NZv3h/oFj+2xGSOGOYGQeDaZ
         Bx7wWx1uHR4XNfGbdOy/RQsGss/4vUOFVCF0KynwPvY+NZDXNvmwkj7d/C97qQ2DH67N
         n2f4XJvEvL66O4EBWIxjwByjNlbpMqN6pV+lOXUWZxK6UGmf+c6uzuR/uNCV/X5+hFFu
         aR44PutR95B9DSg2z6+Bttuq1Gkb9qI7ARULBkjElpyJ4V658jjFBoKP0AYH/Yg6fCV5
         xEYg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5hz5vaYqUX8IQCyW4ZyBWjQQxWvw9H9U2b2s+QBWb3a6rxoDre0RXijZLdGyPj6Ydm+k=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywzb6arMedvvxNgtKIybJXvA2y7bNYuL4h+rGvH7TCMlAsltEry
	heh6hZvh4cd/rbBy2FK5NAezATkoM32k5poOt32lrs7pj21Fj/LMOv12
X-Gm-Gg: AR+sD10sFj+qWmaQoMZLtwGpuSXn7AcSNStnXsdLBfVoXj/6UmASDCMq51hUZLJWvac
	9rdMb/jUTVjuIWiMLrd0/97QLksfDCZNlPictyN6u81oEhRG526ZPqLiTs4V+bXjVZOgpIOjzBr
	uWQcnPWU3L3wdee7krXoJENFpMYoT6scLcQNXBZWj8DGnwyPMwq9u+pmo00ez701tHj3mZu09+y
	E5ygKSRusg3/XOhFnHm95CNj06WmF9giwl4Tk9/kyNwBQB+NNColYEhT16gfv5ecmVuwjgivMxn
	LyqgW5kKZGNO0Arto9QPMEHJiKIbYrUqv4wCfI0y6i0OgsyDwvkQQn2KrXO2HzM0RsUkyeZUyaD
	ApiQb5tfK7/K8nTqVusUGL+sCgyEsgP0ikbtoYoGO0ukJjxFq+Bpg+rEJEJuHYgPpzFHZJroDPS
	vJP30OoriUNv2sZ8YE5q+1raseDVrYuWA4HbWO6E4GxT8qfbFcc7hHdYQEL6Cx64cnKKwr7X+it
	LM22uGEWqisOWaLaoBpOOCs
X-Received: by 2002:a05:6a00:94fc:b0:842:2a81:4c63 with SMTP id d2e1a72fcca58-84e932e61c9mr3805831b3a.25.1785264006353;
        Tue, 28 Jul 2026 11:40:06 -0700 (PDT)
Received: from [10.100.120.121] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03ca2c0sm307951b3a.60.2026.07.28.11.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 11:40:05 -0700 (PDT)
Message-ID: <7a49e746-526b-479b-97a4-0dd34339a66c@gmail.com>
Date: Tue, 28 Jul 2026 11:40:03 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] dbus: expose per-BSS RSN capabilities
To: Aleksman4o <aleksman4o@gmail.com>, iwd@lists.linux.dev
Cc: denkenz@gmail.com
References: <cover.1784069194.git.aleksman4o@gmail.com>
 <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
 <20260728154729.3485557-1-aleksman4o@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260728154729.3485557-1-aleksman4o@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aleks,

On 7/28/26 8:46 AM, Aleksman4o wrote:
> From: Aleks Man <aleksman4o@gmail.com>
>
> James, thanks for the review.  This revision adds the requested iwctl
> support for displaying the new fields.
>
> Network.Type intentionally represents WPA2-Personal, WPA3-Personal, and
> transition networks as "psk".  This series exposes the RSN information
> that iwd already retains for each BSS so consumers can distinguish those
> networks without changing the existing Network API.
>
> The optional BasicServiceSet.RSN dictionary uses the same KeyMgmt,
> Pairwise, and Group fields and values as wpa_supplicant's BSS.RSN
> property.  NetworkManager can therefore reuse its existing parser rather
> than add another translation layer.  Older consumers ignore the optional
> property, and consumers can retain their Network.Type fallback for older
> iwd versions.
>
> The corresponding NetworkManager MR reads and combines the per-BSS
> capabilities for its synthetic ESS access point:
> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/merge_requests/2464
>
> Validation:
>
>    - make check: 273 passed, 6 skipped, 0 failed.
>    - The installed patched iwd exposes the expected KeyMgmt, Pairwise, and
>      Group values on a physical WPA2/WPA3 transition BSS.
>    - The new iwctl output displays the capabilities in the get-bsses table.
>    - An SAE profile auto-connects after restarting iwd and remains visible
>      as connected in NetworkManager and the Plasma applet.
>    - A NetworkManager disconnect/reconnect completes without a password
>      prompt and reconnects as WPA3-Personal with FT.
>    - The upstream CI suite passed all checks for v3.
>
> Changes in v4:
>    - Add iwctl parsing and display of the BasicServiceSet RSN dictionary,
>      as requested by James.
>    - Widen get-bsses property values so the capabilities remain readable
>      while the table stays within 80 columns.
>    - No changes to patches 1-3.
>
> Changes in v3:
>    - Shorten the auto-t filename so the generated patch metadata complies
>      with GitLint's 80-column limit.  There are no code changes.
>
> Changes in v2:
>    - Resend with git-send-email after the Gmail web client corrupted the
>      inline v1 patches.  There are no code changes.
>
> RFC:
> https://lore.kernel.org/iwd/CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC%2BRaJKsKz0sUivGAQHXA@mail.gmail.com/
>
> Related NetworkManager issues:
> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1489
> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1693
>
> Aleks Man (5):
>    network: expose RSN capabilities on BSS
>    doc: document BasicServiceSet RSN property
>    auto-t: test BasicServiceSet RSN property
>    client: display BasicServiceSet RSN property
>    client: widen BSS property value column
>
>   .../testBasicServiceSetRSN/bss_rsn_test.py    |  70 +++++++++++
>   autotests/testBasicServiceSetRSN/hw.conf      |   9 ++
>   autotests/testBasicServiceSetRSN/ssidSAE.conf |  11 ++
>   .../ssidTransition.conf                       |  12 ++
>   .../testBasicServiceSetRSN/ssidWPA2.conf      |   8 ++
>   client/bss.c                                  |  76 ++++++++++++
>   client/station.c                              |   4 +-
>   doc/basic-service-set.txt                     |  23 ++++
>   src/network.c                                 | 110 ++++++++++++++++++
>   9 files changed, 321 insertions(+), 2 deletions(-)
>   create mode 100644 autotests/testBasicServiceSetRSN/bss_rsn_test.py
>   create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
>   create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
>   create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
>   create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf
>
Thanks for the quick turn around. These LGTM. Standby about merging, 
we'll get these in as soon as we can.

Thanks,

James

