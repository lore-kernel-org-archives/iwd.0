Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D51635CF
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098380; cv=none; b=TIisyO7U/tqf2DUPwMt4DXCwe89Csdra6Rzne4rBfYs7wqp/WoFr/y2z4Un24nrvhy+hMnTkWvZi1/p80XqFcSS/f6GDy8AevlAGk0LB1NhcJpd0HCNjKC4nIt+EuxDf+mCZh2rS6W2R7u6jiL5SCcJMDVoLFiJZc0WDvswK3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098380; c=relaxed/simple;
	bh=3YHxKJvMaD/bcVg9GZbEHWJy9WkcpK0T4BnLGAMe6uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PgELZGgi+kmomGW54S5fecLMK5a6HWeIE6T1atidJrJ8suDg65uOySrkWkTfLX0zsXxXFeDT4wvcbbc4QoFa4S/eGQRgN+jLChkoK/IwvdcWIHWT6RyxLdK4cG6epmv+3QvSYj+mJd2S2sOlhjyH7Lm40qpCUT4+2Wx0CCBstvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXDOWXVz; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXDOWXVz"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23d621abfb7so1512966fac.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098378; x=1715703178; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HAaZ7hFJVRvb+pRLvMIHpbE8/2YuzA/dl2SVn38T/54=;
        b=SXDOWXVz26vEHxPCE1Uw3ln5wcHdomAG2gfLPuSHAPG4wZcPiy6W1Mv9lNZAeO5dhi
         u881axQplYz/YweL8+GSwOqpuGNCX/qlD4aMXsdDsMSXagWPdnGwbuFba6x1n2d0GMgO
         S4afe8+6sHtRL/300zURE+qqfUErtg8dysXGiqr9YCit5QIPoOaXPumAvWYaDK2Iryem
         zMi/mCUq4FFfSevkEx0QbCt9VRJ95eXhVWpb3OzwLkUzREaU3h+f9P6CvAd0VLKtGQgv
         0HKNaj5ITI7qxzGKiTBtbs8QCEyvBr2b723qyGLUbzwNAbEztQli2+oAzTcyUAik7tUD
         zgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098378; x=1715703178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAaZ7hFJVRvb+pRLvMIHpbE8/2YuzA/dl2SVn38T/54=;
        b=Vve39SHTMDdodv1GoE0cj+0LMX3s06OjvA84mPqxhwFIZzmqHmCi5FxVrqITrioAUu
         XPpCOH3M4nmdL76pVDwOoOPHNfjnoblkzlQeyBgv0fFAxQ8chL/LQzIdOnSOTtGABKWq
         uKhR3/fGAhOsHxnMpQ8qqx1X02HJv9JeVONufN7RAp0iZrcbn3xFhtL1uJIvfNypM+Bl
         Y6XpUBuCYra4y7JZ38NKYaJj4zlOpVLOnz+9soAclAe2/1K05fzXhtF19pFZ166G8you
         vphRPgVT6GXLpk9svOLTVOrJ1j4L1ldfkZQihrR/LFDk3dusk7QMLp9uEBML5MaM+7pA
         u+rA==
X-Forwarded-Encrypted: i=1; AJvYcCUx/m8RdUF8otpLL9YUC06dufSmdH786goYShID6M4ZQoFwJudIXyVTHpuFoMGu+Goc9ENgcreqGa4u4x6SM7OQyldb
X-Gm-Message-State: AOJu0YyDma7nlk+yKjkCzoL2DCBRvX94QY8hgp8S661lctzPnjzjQ8hj
	2vmBalqDAtwWF+egLkCpC4SNIjyaXAQzS6acg4DjQi+fpMQy+GLY
X-Google-Smtp-Source: AGHT+IF0PzZQxTZyyKrSGUDc2NToHBEZGo/FojTTircxbZmdec0ESjCE2Ts4t/IOeqQJMAiwkifBwA==
X-Received: by 2002:a05:6870:2041:b0:22a:956:8f71 with SMTP id 586e51a60fabf-24019fb1164mr1457989fac.28.1715098377829;
        Tue, 07 May 2024 09:12:57 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s7-20020a0568302a8700b006ee4e216d02sm2529457otu.14.2024.05.07.09.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:12:57 -0700 (PDT)
Message-ID: <3baa870c-1d24-4218-8162-6118957b77fc@gmail.com>
Date: Tue, 7 May 2024 11:12:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] ap: move toward requiring MFP when using SAE
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-15-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-15-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> When wanting to use SAE, confirm that MFP is also supported, and
> automatically enable MFP. Advertise as MFP capable in the beacon.
> ---
>   src/ap.c    | 13 +++++++++++--
>   src/wiphy.c |  2 +-
>   src/wiphy.h |  2 ++
>   3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/src/ap.c b/src/ap.c
> index ae406e16..8cebef42 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -82,6 +82,7 @@ struct ap_state {
>   
>   	unsigned int ciphers;
>   	enum ie_rsn_cipher_suite group_cipher;
> +	enum ie_rsn_cipher_suite group_management_cipher;
>   	unsigned int akm_suites;
>   	uint32_t beacon_interval;
>   	struct l_uintset *rates;
> @@ -93,6 +94,7 @@ struct ap_state {
>   	struct l_timeout *wsc_pbc_timeout;
>   	uint16_t wsc_dpid;
>   	uint8_t wsc_uuid_r[16];
> +	bool mfpc;
>   
>   	uint16_t last_aid;
>   	struct l_queue *sta_states;
> @@ -639,6 +641,9 @@ static void ap_set_rsn_info(struct ap_state *ap, struct ie_rsn_info *rsn)
>   	rsn->akm_suites = ap->akm_suites;
>   	rsn->pairwise_ciphers = ap->ciphers;
>   	rsn->group_cipher = ap->group_cipher;
> +
> +	rsn->group_management_cipher = ap->group_management_cipher;
> +	rsn->mfpc = ap->mfpc;
>   }
>   
>   static void ap_wsc_exit_pbc(struct ap_state *ap)
> @@ -3916,9 +3921,13 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
>   	for (i = 0; akms_str && akms_str[i]; i++) {
>   		if (!strcmp(akms_str[i], "PSK"))
>   			ap->akm_suites |= IE_RSN_AKM_SUITE_PSK;
> -		else if (!strcmp(akms_str[i], "SAE"))
> +		else if (!strcmp(akms_str[i], "SAE")) {
> +			if (!wiphy_can_connect_sae(wiphy))

wiphy_can_connect_sae checks NL80211_FEATURE_SAE and 
NL80211_EXT_FEATURE_SAE_OFFLOAD bit, which is for clients only.  The AP 
equivalent is NL80211_EXT_FEATURE_SAE_OFFLOAD_AP.  Refer to linux/nl80211.h for 
more details.  You're probably better off using wiphy_get_supported_ciphers instead.

> +				return -ENOTSUP;
>   			ap->akm_suites |= IE_RSN_AKM_SUITE_SAE_SHA256;
> -		else {
> +			ap->group_management_cipher = IE_RSN_CIPHER_SUITE_BIP_CMAC;
> +			ap->mfpc = true;
> +		} else {
>   			l_warn("Unsupported or unknown AKM suite %s",
>   					akms_str[i]);
>   			return -ENOTSUP;

Regards,
-Denis

