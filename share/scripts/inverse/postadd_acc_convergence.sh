#! /bin/bash
#
# Copyright 2009 The VOTCA Development Team (http://www.votca.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if [ "$1" = "--help" ]; then
cat <<EOF
${0##*/}, version %version%
postadd accumulate convergence script
accumulate \${name}.conv of all steps

Usage: ${0##*/} infile outfile

USES: die check_deps run_or_exit do_external cp_from_last_step touch get_last_step_dir get_current_step_nr

NEEDS: inverse.post_add_options.copyback.filelist name
EOF
   exit 0
fi

check_deps "$0"

[ -z "$2" ] && die "${0##*/}: Missing arguments"

name=$(csg_get_interaction_property name)
lastdir=$(get_last_step_dir)

if [ -f "${lastdir}/${name}.aconv" ]; then
  cp_from_last_step "${name}.aconv"
else
  touch "${name}.aconv"
fi

if [ -f "${name}.conv" ]; then
  do_external postadd dummy "$1" "$2"
else
  do_external postadd convergence "$1" "$2"
fi

true_or_exit echo "$(get_current_step_nr) $(cat ${name}.conv)" >> "${name}.aconv"