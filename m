Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046B47772
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPfJGoXK"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b8b556aadbso2995630b6e.3
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701880598; x=1702485398; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mc3AUsay38qD/CPxSIn9edj/a75wThq+GzsPIVYw6IE=;
        b=TPfJGoXK9C/+KI6+ulv0rv6xKli82kHWB0Ok52guNr0Hypa6Lq88ps9uzNtX2DE6qI
         KVZu+7zI8pkBOoA7+VYHSIRU/ss2X2Jvdh66fAgm1grZDgGUb8YP19+cFFzFEy4kkwwm
         boYHfm6f3Td8At9bdbQ+o6yoWlhRsSitBCE8b0FSQViJMt0vBT3CEDi1bM9Ow+NypqM7
         kCkgxT0ZptRlieiJFFwCc3Ya382WETib63dUNIfoLS7YFp3440B47zylitOL77ze9eJZ
         mZG34GTQxLC+XBDbHhyzDYxRJ+kQcx7ZGw2TXKMcI+sJY12Csq7T/3rwUXP45sp5maqt
         UssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880598; x=1702485398;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mc3AUsay38qD/CPxSIn9edj/a75wThq+GzsPIVYw6IE=;
        b=uHkTqjcuqY0EOsWVx4vaES1rCjSu8JGxQgl/rjJml31v4vAyaUdqD/PAx2kEdPsA+T
         3JcvLSh1smjkguqa3Da74gPX8p4yWHHLmMhExR4XPRyPXk9G1lflDuyVMM5/LkkHNsjO
         QVvdJquQd5AAxi7cbnBnParrfUfR4OTte7JHUozzSXYBZmpdgP3QlNe97oc/sxqpFE8Q
         8VIXZZ0RPqN5xf1GAgMFL1UHN2e9GN+pUHpvyt+VCVEqTeMbxWtYKKX36NKj2Sw7Lnfs
         FbFuKtJqT3pN1TTB/+Bavr0q1Oqu4d6nTXC3g8uR6MR9mdTOdbUcU1t40gLtSmrNMPFO
         930g==
X-Gm-Message-State: AOJu0YwjXrR6VzSSDY/pV0oPqOYXChHiruRKBZG+9ZOOibrb36u5x9Xv
	xVsx0JM+caIOQjEsO47x0LY=
X-Google-Smtp-Source: AGHT+IGDBbUCCaWuK0ttRWdtquLXI5tLgBae74sMmzlUBDYbPGhXgrSLAHtkFGMFSbTWofMj/ieiDw==
X-Received: by 2002:a05:6808:1802:b0:3b8:9ccb:737a with SMTP id bh2-20020a056808180200b003b89ccb737amr1313020oib.22.1701880598336;
        Wed, 06 Dec 2023 08:36:38 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bh1-20020a056808180100b003b897b71e11sm45333oib.56.2023.12.06.08.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:36:38 -0800 (PST)
Message-ID: <620a779d-e694-4057-846d-23e6eea35252@gmail.com>
Date: Wed, 6 Dec 2023 10:36:37 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] ft: add FTE/RSNE building to ft_prepare_handshake
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231206150708.2080336-1-prestwoj@gmail.com>
 <20231206150708.2080336-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231206150708.2080336-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/6/23 09:07, James Prestwood wrote:
> In preparation to remove ft_associate build the FTE/RSNE in
> ft_prepare_handshake and set into the handshake object directly.
> ---
>   src/ft.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 82 insertions(+), 2 deletions(-)
> 

<snip>

> @@ -931,6 +937,80 @@ static void ft_prepare_handshake(struct ft_info *info,
>   						info->ft_info.r1khid);
>   
>   	handshake_state_derive_ptk(hs);
> +
> +	/*
> +	 * Rebuild the RSNE to include the PMKR1Name and append
> +	 * MDE + FTE.
> +	 *
> +	 * 12.8.4: "If present, the RSNE shall be set as follows:
> +	 * - Version field shall be set to 1.
> +	 * - PMKID Count field shall be set to 1.
> +	 * - PMKID field shall contain the PMKR1Name.
> +	 * - All other fields shall be as specified in 8.4.2.27
> +	 *   and 11.5.3."
> +	 */
> +	if (ie_parse_rsne_from_data(hs->supplicant_ie,
> +					hs->supplicant_ie[1] + 2,
> +					&rsn_info) < 0)
> +		return false;
> +
> +	rsn_info.num_pmkids = 1;
> +	rsn_info.pmkids = hs->pmk_r1_name;
> +	/* Always set OCVC false for FT for now */
> +	rsn_info.ocvc = false;
> +	rsne = alloca(256);
> +
> +	ie_build_rsne(&rsn_info, rsne);
> +	handshake_state_set_supplicant_ie(hs, rsne);

This is probably safe since we over-write the supplicant ie in 
netdev_connect_event() -> parse_request_ies()

> +
> +	/*
> +	 * 12.8.4: "If present, the FTE shall be set as follows:
> +	 * - ANonce, SNonce, R0KH-ID, and R1KH-ID shall be set to
> +	 *   the values contained in the second message of this
> +	 *   sequence.
> +	 * - The Element Count field of the MIC Control field shall
> +	 *   be set to the number of elements protected in this
> +	 *   frame (variable).
> +	 * [...]
> +	 * - All other fields shall be set to 0."
> +	 */
> +	memset(&ft_info, 0, sizeof(ft_info));
> +	ft_info.mic_element_count = 3;
> +	memcpy(ft_info.r0khid, hs->r0khid, hs->r0khid_len);
> +	ft_info.r0khid_len = hs->r0khid_len;
> +	memcpy(ft_info.r1khid, hs->r1khid, 6);
> +	ft_info.r1khid_present = true;
> +	memcpy(ft_info.anonce, hs->anonce, 32);
> +	memcpy(ft_info.snonce, hs->snonce, 32);
> +
> +	/*
> +	 * IEEE 802.11-2020 Section 13.7.1 FT reassociation in an RSN
> +	 *
> +	 * "If dot11RSNAOperatingChannelValidationActivated is true and
> +	 *  the FTO indicates OCVC capability, the target AP shall
> +	 *  ensure that OCI subelement of the FTE matches by ensuring
> +	 *  that all of the following are true:
> +	 *      - OCI subelement is present
> +	 *      - Channel information in the OCI matches current
> +	 *        operating channel parameters (see 12.2.9)"
> +	 */
> +	if (hs->supplicant_ocvc && hs->chandef) {
> +		oci_from_chandef(hs->chandef, ft_info.oci);
> +		ft_info.oci_present = true;
> +	}
> +
> +	fte = alloca(256);
> +	ie_build_fast_bss_transition(&ft_info, kck_len, fte);
> +
> +	if (!ft_calculate_fte_mic(hs, 5, rsne, fte, NULL, ft_info.mic))
> +		return false;
> +
> +	/* Rebuild the FT IE now with the MIC included */
> +	ie_build_fast_bss_transition(&ft_info, kck_len, fte);
> +
> +	handshake_state_set_fte(hs, fte);

However, this is less clear to me.  Looking at how FILS and FT uses this API, it 
seems that set_fte is meant for the authenticator FTE element?  So I think 
rekeying after FT would be broken by this change.

> +
> +	return true;
>   }
>   
>   static bool ft_send_action(struct wiphy_radio_work_item *work)

Regards,
-Denis
