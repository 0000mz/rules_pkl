# Transform an input pkl file to the specified config format
# and write it to the destination.

import subprocess
import sys
import argparse
import logging

def perform_pkl_transform(pkl_config_path: str, target_format: str, output_path: str):
    args = [
        "pkl",
        "eval",
        "-f",
        target_format,
        pkl_config_path,
    ]
    logging.debug("pkl transform args: {}".format(' '.join(args)))
    with open(output_path, 'w') as f:
        subprocess.run(args, stdout=f)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description = "pkl transformer")
    # TODO: Add argument for specifying the pkl executable path once the pkl exe is being
    # built by bazel.
    parser.add_argument(
        '--config_file',
        type=str,
        dest="config_file",
        help="The pkl config file to transform.",
        required=True)
    parser.add_argument(
        '--format',
        type=str,
        dest="format",
        help="The target format to transform the pkl file to.",
        required=True)
    parser.add_argument(
        '--output',
        type=str,
        dest="output",
        help="The destination to save the transformed pkl file output.",
        required=True)
    
    args = parser.parse_args()
    perform_pkl_transform(args.config_file, args.format, args.output)
